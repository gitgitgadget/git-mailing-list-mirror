From: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
Subject: [tig PATCH v2 1/2] Popup menu
Date: Sun, 22 Feb 2009 15:09:37 +0100
Message-ID: <1235311778-11112-2-git-send-email-giuseppe.bilotta@gmail.com>
References: <1235311778-11112-1-git-send-email-giuseppe.bilotta@gmail.com>
Cc: git@vger.kernel.org, Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
To: Jonas Fonseca <jonas.fonseca@gmail.com>
X-From: git-owner@vger.kernel.org Sun Feb 22 15:13:54 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LbF5W-0000yv-Ei
	for gcvg-git-2@gmane.org; Sun, 22 Feb 2009 15:13:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752634AbZBVOJs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 22 Feb 2009 09:09:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752298AbZBVOJs
	(ORCPT <rfc822;git-outgoing>); Sun, 22 Feb 2009 09:09:48 -0500
Received: from fg-out-1718.google.com ([72.14.220.159]:58998 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752367AbZBVOJq (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 22 Feb 2009 09:09:46 -0500
Received: by fg-out-1718.google.com with SMTP id 16so2423942fgg.17
        for <git@vger.kernel.org>; Sun, 22 Feb 2009 06:09:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=koXJQitE0ZjVvHgdAb3WmvBhZGiBeGdvW9vjm4J4b9Y=;
        b=a00ofqyxKtSyLxjzPN+vntR5C1RuXIg8p5842JJ1APVaLeqLdNjy41eQqCuMPAO3S5
         Uru4Hwy5vRsKql80wlT8eL4Nt+oku+pRX+IipI7WXrhoIoqMisVNm9UYTe0dYG9829XH
         /OSZlXK+cdtAUKX4FZLZqARF1ebLiOcBj+Ybw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=hKkVTxdkVUv4psySm4sxi1Nk4P91OUlAeg3bZ8gar2LcBeUWFyZfRRaFoK5qxpItrl
         D7d9h2c8H0gqI8iW97PMTqQJ13Jr9Ym8DgUi0tkd5GZhLjhhk1EyW3PvoF7lcgDYsd6J
         lDO/eHks1owrRk/jxujMOIqc3JjcvccVAy6v8=
Received: by 10.86.89.20 with SMTP id m20mr2273964fgb.71.1235311785625;
        Sun, 22 Feb 2009 06:09:45 -0800 (PST)
Received: from localhost (host-78-15-3-150.cust-adsl.tiscali.it [78.15.3.150])
        by mx.google.com with ESMTPS id l12sm5338449fgb.31.2009.02.22.06.09.44
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 22 Feb 2009 06:09:45 -0800 (PST)
X-Mailer: git-send-email 1.6.2.rc1.258.g1d592.dirty
In-Reply-To: <1235311778-11112-1-git-send-email-giuseppe.bilotta@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/111007>

Make the menu into a popup window that complements the status prompt.

Signed-off-by: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
---
 tig.c |  115 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++-
 1 files changed, 113 insertions(+), 2 deletions(-)

diff --git a/tig.c b/tig.c
index 20a40b9..9b9c34b 100644
--- a/tig.c
+++ b/tig.c
@@ -6542,6 +6542,98 @@ utf8_length(const char **start, size_t skip, int *width, size_t max_width, int *
 	return string - *start;
 }
 
+/*
+ * Popup management
+ */
+
+struct popup {
+	WINDOW *win;
+	int width;
+	bool hotkeys;
+	int selected;
+};
+
+static struct popup menu;
+
+
+static void
+menu_popup(void)
+{
+	wnoutrefresh(menu.win);
+}
+
+static void
+menu_popdown(void)
+{
+	delwin(menu.win);
+	menu.win = NULL;
+	redraw_display(FALSE);
+}
+
+static void
+menu_create(int height, int width, const char* title, bool hotkeys)
+{
+	WINDOW *win;
+	int ymax, xmax, top, left;
+	enum line_type type = LINE_TITLE_FOCUS;
+
+	getmaxyx(stdscr, ymax, xmax);
+	top = (ymax - height)/2;
+	left = (xmax - width)/2;
+	if (top < 0)
+		top = 0;
+	if (left < 0)
+		left = 0;
+
+	win = newwin(height, width, top, left);
+	wbkgd(win, COLOR_PAIR(type));
+
+	box(win, 0, 0);
+	wattrset(win, get_line_attr(type));
+	mvwprintw(win, 0, (width-strlen(title))/2, " %s ", title);
+
+	menu.win = win;
+	menu.width = width;
+	menu.hotkeys = hotkeys;
+	menu.selected = -1;
+}
+
+static void
+menu_set_line_attr(int index, enum line_type type)
+{
+	WINDOW *win = menu.win;
+	int width = menu.width-2;
+	mvwchgat(win, index+1, 1, width,
+			get_line_attr(type), type, NULL);
+}
+
+static void
+menu_putline(int index, const struct menu_item *item)
+{
+	WINDOW *win = menu.win;
+	bool hotkeys = menu.hotkeys;
+	if (hotkeys) {
+		if (item->hotkey)
+			mvwprintw(win, index+1, 2, "[%c] %s", (char) item->hotkey, item->text);
+		else
+			mvwprintw(win, index+1, 6, "%s", item->text);
+	} else {
+		mvwprintw(win, index+1, 2, "%s", item->text);
+	}
+}
+
+static void
+menu_select(int index)
+{
+	if (menu.selected >= 0) {
+		menu_set_line_attr(menu.selected, LINE_TITLE_FOCUS);
+	}
+	if (index >= 0) {
+		menu_set_line_attr(index, LINE_CURSOR);
+	}
+	menu.selected = index;
+	menu_popup();
+}
 
 /*
  * Status management
@@ -6836,14 +6928,30 @@ static bool prompt_menu(const char *prompt, const struct menu_item *items, int *
 {
 	enum input_status status = INPUT_OK;
 	int size = 0;
+	int width = strlen(prompt+2);
+	bool hotkeys = false;
+	int i;
 
-	while (items[size].text)
+	while (items[size].text) {
+		int w = strlen(items[size].text);
+		if (w > width)
+			width = w;
+		if (items[size].hotkey)
+			hotkeys = true;
 		size++;
+	}
+	/* padding */
+	width += hotkeys ? 8 : 4;
+
+	menu_create(size+2, width, prompt, hotkeys);
+	for (i=0; i < size; ++i)
+		menu_putline(i, &items[i]);
+	menu_popup();
+
 
 	while (status == INPUT_OK) {
 		const struct menu_item *item = &items[*selected];
 		int key;
-		int i;
 
 		mvwprintw(status_win, 0, 0, "%s (%d of %d) ",
 			  prompt, *selected + 1, size);
@@ -6851,6 +6959,7 @@ static bool prompt_menu(const char *prompt, const struct menu_item *items, int *
 			wprintw(status_win, "[%c] ", (char) item->hotkey);
 		wprintw(status_win, "%s", item->text);
 		wclrtoeol(status_win);
+		menu_select(*selected);
 
 		key = get_input(COLS - 1);
 		switch (key) {
@@ -6886,6 +6995,8 @@ static bool prompt_menu(const char *prompt, const struct menu_item *items, int *
 		}
 	}
 
+	menu_popdown();
+
 	/* Clear the status window */
 	status_empty = FALSE;
 	report("");
-- 
1.6.2.rc1.258.g1d592.dirty
