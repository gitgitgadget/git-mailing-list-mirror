From: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
Subject: [PATCH] Popup menu
Date: Sun, 22 Feb 2009 12:40:19 +0100
Message-ID: <1235302820-32526-1-git-send-email-giuseppe.bilotta@gmail.com>
Cc: git@vger.kernel.org, Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
To: Jonas Fonseca <jonas.fonseca@gmail.com>
X-From: git-owner@vger.kernel.org Sun Feb 22 12:42:00 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LbCib-00055S-6p
	for gcvg-git-2@gmane.org; Sun, 22 Feb 2009 12:41:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753750AbZBVLk3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 22 Feb 2009 06:40:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753551AbZBVLk2
	(ORCPT <rfc822;git-outgoing>); Sun, 22 Feb 2009 06:40:28 -0500
Received: from mail-fx0-f167.google.com ([209.85.220.167]:36788 "EHLO
	mail-fx0-f167.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753328AbZBVLk1 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 22 Feb 2009 06:40:27 -0500
Received: by fxm11 with SMTP id 11so928534fxm.13
        for <git@vger.kernel.org>; Sun, 22 Feb 2009 03:40:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer;
        bh=F24X/60PaYlYtykgA6r9B1Y8bL/mL4sLCZFgrL1MVCA=;
        b=iCev1NRzNMneJn+/2e3UHq6OtfcNeBruXP20R18FWUPALMx+3Y3NuHDNivJ+tAWX2I
         8Cna+pKhnPc21kafDWab6/G9LJv24Rd1KzbwzD3ez6UuCki3h2nH/iEKy5Ws0kQvc30t
         fBBwdoojBqnfwkxovDd1OzB/hCydgObdKQkCU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=wJ9PRfC4vmLt/QO5sNoMVwkfzUk1pxnkgjGUxH5IsABpZURvhZ7N1BRfFJf36kiKhh
         ig2kbXL2lahAd2NM9AfHUe6lGiSwBss1ucxcPfIZSmpTI1huGV27SuqHEzFT99NIuI5S
         u7SuKxKNnHnl14hhRdf5DxR1asT696ehycT2E=
Received: by 10.103.218.9 with SMTP id v9mr2765545muq.78.1235302824771;
        Sun, 22 Feb 2009 03:40:24 -0800 (PST)
Received: from localhost ([94.37.0.89])
        by mx.google.com with ESMTPS id n7sm1686996mue.6.2009.02.22.03.40.23
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 22 Feb 2009 03:40:24 -0800 (PST)
X-Mailer: git-send-email 1.6.2.rc1.258.g1d592.dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/110998>

Make the menu into a popup window that complements the status prompt.

Signed-off-by: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
---

We should probably consider using the high-level menu and panel features from
ncurses if we want to do anything more complex.

 tig.c |  117 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++-
 1 files changed, 115 insertions(+), 2 deletions(-)

diff --git a/tig.c b/tig.c
index 20a40b9..017b05f 100644
--- a/tig.c
+++ b/tig.c
@@ -6542,6 +6542,100 @@ utf8_length(const char **start, size_t skip, int *width, size_t max_width, int *
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
+	WINDOW *win = menu.win;
+	int width = menu.width-2;
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
@@ -6836,14 +6930,30 @@ static bool prompt_menu(const char *prompt, const struct menu_item *items, int *
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
@@ -6851,6 +6961,7 @@ static bool prompt_menu(const char *prompt, const struct menu_item *items, int *
 			wprintw(status_win, "[%c] ", (char) item->hotkey);
 		wprintw(status_win, "%s", item->text);
 		wclrtoeol(status_win);
+		menu_select(*selected);
 
 		key = get_input(COLS - 1);
 		switch (key) {
@@ -6886,6 +6997,8 @@ static bool prompt_menu(const char *prompt, const struct menu_item *items, int *
 		}
 	}
 
+	menu_popdown();
+
 	/* Clear the status window */
 	status_empty = FALSE;
 	report("");
-- 
1.6.2.rc1.258.g1d592.dirty
