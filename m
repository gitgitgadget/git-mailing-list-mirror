From: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
Subject: [tig PATCH v2bis 2/2] Popup menu: redraw as needed
Date: Sun, 22 Feb 2009 19:36:32 +0100
Message-ID: <1235327792-12338-1-git-send-email-giuseppe.bilotta@gmail.com>
References: <1235311778-11112-3-git-send-email-giuseppe.bilotta@gmail.com>
Cc: git@vger.kernel.org, Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
To: Jonas Fonseca <jonas.fonseca@gmail.com>
X-From: git-owner@vger.kernel.org Sun Feb 22 19:38:10 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LbJDN-000598-M1
	for gcvg-git-2@gmane.org; Sun, 22 Feb 2009 19:38:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751856AbZBVSgk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 22 Feb 2009 13:36:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751844AbZBVSgk
	(ORCPT <rfc822;git-outgoing>); Sun, 22 Feb 2009 13:36:40 -0500
Received: from mail-fx0-f167.google.com ([209.85.220.167]:51412 "EHLO
	mail-fx0-f167.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751800AbZBVSgj (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 22 Feb 2009 13:36:39 -0500
Received: by fxm11 with SMTP id 11so1123346fxm.13
        for <git@vger.kernel.org>; Sun, 22 Feb 2009 10:36:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=MHgMHKTSPMETp7WEFCbIAPtcIET9V0weHQ5sVtJSvg0=;
        b=arW4nlltHSOVcqLy43JMT5Gz0SH0+eMTZq9NnYmACuWtzED9JjmjQAdrXhqz0p4l5a
         rVpVIhWle2EQLt1sd5D78ds6OcUE4HDUYG5Fls817EMSAU7HyZvecymfTOQq44gum5iD
         HoBtuyvoepJT1NuO3rm7XNPap+KvGcLNeOjDs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=sbMLtat0yd02g7Z26Go/y9UlASiDi6HR98Mkh3yY0rPLd1Qg6EU9hAYNS8wNzuOIWz
         5qHEhxJ5emJiqRFxhSQ3goq5Ev5akp0q0WP8LA5bT6wtoikF0fHdaxoYb2wCcbNeYW90
         1ZrzzBPIQ3kEh4EA0EoU7tAr5/7hiNW8J7yBY=
Received: by 10.103.198.20 with SMTP id a20mr2889203muq.63.1235327797187;
        Sun, 22 Feb 2009 10:36:37 -0800 (PST)
Received: from localhost (host-78-15-3-150.cust-adsl.tiscali.it [78.15.3.150])
        by mx.google.com with ESMTPS id i7sm1776534mue.44.2009.02.22.10.36.35
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 22 Feb 2009 10:36:36 -0800 (PST)
X-Mailer: git-send-email 1.6.2.rc1.258.g1d592.dirty
In-Reply-To: <1235311778-11112-3-git-send-email-giuseppe.bilotta@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/111045>

Redraw the popup menu after a resize or an update during background
loading.

Signed-off-by: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
---
Of course, I forgot some leftovers here too. Here's the cleaned up patch for this.

 tig.c |  126 ++++++++++++++++++++++++++++++++++++++++++-----------------------
 1 files changed, 82 insertions(+), 44 deletions(-)

diff --git a/tig.c b/tig.c
index 9b9c34b..1d7dcce 100644
--- a/tig.c
+++ b/tig.c
@@ -2274,6 +2274,8 @@ resize_display(void)
 	}
 }
 
+static void menu_redraw(void);
+
 static void
 redraw_display(bool clear)
 {
@@ -2286,6 +2288,8 @@ redraw_display(bool clear)
 		redraw_view(view);
 		update_view_title(view);
 	}
+
+	menu_redraw();
 }
 
 static void
@@ -2952,6 +2956,10 @@ update_view(struct view *view)
 	/* Update the title _after_ the redraw so that if the redraw picks up a
 	 * commit reference in view->ref it'll be available here. */
 	update_view_title(view);
+
+	/* Redraw menu if needed */
+	menu_redraw();
+
 	return TRUE;
 }
 
@@ -6549,6 +6557,9 @@ utf8_length(const char **start, size_t skip, int *width, size_t max_width, int *
 struct popup {
 	WINDOW *win;
 	int width;
+	int height;
+	const char *title;
+	const struct menu_item *items;
 	bool hotkeys;
 	int selected;
 };
@@ -6557,6 +6568,32 @@ static struct popup menu;
 
 
 static void
+menu_set_line_attr(int index, enum line_type type)
+{
+	WINDOW *win = menu.win;
+	int width = menu.width-2;
+	mvwchgat(win, index+1, 1, width,
+			get_line_attr(type), type, NULL);
+}
+
+static void
+menu_putline(int index, const struct menu_item *item, bool selected)
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
+	if (selected)
+		menu_set_line_attr(index, LINE_CURSOR);
+}
+
+static void
 menu_popup(void)
 {
 	wnoutrefresh(menu.win);
@@ -6571,55 +6608,60 @@ menu_popdown(void)
 }
 
 static void
-menu_create(int height, int width, const char* title, bool hotkeys)
+menu_redraw(void)
 {
-	WINDOW *win;
-	int ymax, xmax, top, left;
-	enum line_type type = LINE_TITLE_FOCUS;
+	WINDOW *win = menu.win;
+	if (win)
+	{
+		int width = menu.width;
+		int height = menu.height;
+		const char *title = menu.title;
+		const struct menu_item *items = menu.items;
 
-	getmaxyx(stdscr, ymax, xmax);
-	top = (ymax - height)/2;
-	left = (xmax - width)/2;
-	if (top < 0)
-		top = 0;
-	if (left < 0)
-		left = 0;
+		int ymax, xmax, top, left;
+		enum line_type type = LINE_TITLE_FOCUS;
+		int i;
 
-	win = newwin(height, width, top, left);
-	wbkgd(win, COLOR_PAIR(type));
+		getmaxyx(stdscr, ymax, xmax);
+		top = (ymax - height)/2;
+		left = (xmax - width)/2;
+		if (top < 0)
+			top = 0;
+		if (left < 0)
+			left = 0;
 
-	box(win, 0, 0);
-	wattrset(win, get_line_attr(type));
-	mvwprintw(win, 0, (width-strlen(title))/2, " %s ", title);
+		mvwin(win, top, left);
+		wbkgd(win, COLOR_PAIR(type));
 
-	menu.win = win;
-	menu.width = width;
-	menu.hotkeys = hotkeys;
-	menu.selected = -1;
-}
+		box(win, 0, 0);
+		wattrset(win, get_line_attr(type));
+		mvwprintw(win, 0, (width-strlen(title))/2, " %s ", title);
 
-static void
-menu_set_line_attr(int index, enum line_type type)
-{
-	WINDOW *win = menu.win;
-	int width = menu.width-2;
-	mvwchgat(win, index+1, 1, width,
-			get_line_attr(type), type, NULL);
+		for (i=0; items[i].text; ++i)
+			menu_putline(i, &items[i], i==menu.selected);
+
+		menu_popup();
+	}
 }
 
 static void
-menu_putline(int index, const struct menu_item *item)
+menu_create(int height, int width, const char *title, const struct menu_item *items)
 {
-	WINDOW *win = menu.win;
-	bool hotkeys = menu.hotkeys;
-	if (hotkeys) {
-		if (item->hotkey)
-			mvwprintw(win, index+1, 2, "[%c] %s", (char) item->hotkey, item->text);
-		else
-			mvwprintw(win, index+1, 6, "%s", item->text);
-	} else {
-		mvwprintw(win, index+1, 2, "%s", item->text);
-	}
+	int i=0;
+	menu.win = newwin(height, width, 0, 0);
+	menu.width = width;
+	menu.height = height;
+	menu.title = title;
+	menu.items = items;
+	menu.hotkeys = false;
+	for(;items[i].text;++i)
+		if (items[i].hotkey) {
+			menu.hotkeys=true;
+			break;
+		}
+	menu.selected = -1;
+
+	menu_redraw();
 }
 
 static void
@@ -6943,11 +6985,7 @@ static bool prompt_menu(const char *prompt, const struct menu_item *items, int *
 	/* padding */
 	width += hotkeys ? 8 : 4;
 
-	menu_create(size+2, width, prompt, hotkeys);
-	for (i=0; i < size; ++i)
-		menu_putline(i, &items[i]);
-	menu_popup();
-
+	menu_create(size+2, width, prompt, items);
 
 	while (status == INPUT_OK) {
 		const struct menu_item *item = &items[*selected];
-- 
1.6.2.rc1.258.g1d592.dirty
