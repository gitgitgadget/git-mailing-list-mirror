From: =?utf-8?q?SZEDER=20G=C3=A1bor?= <szeder@ira.uka.de>
Subject: [PATCH 2/3] Refactor loading xml UI files
Date: Tue,  3 Feb 2009 14:08:50 +0100
Message-ID: <1233666531-21589-2-git-send-email-szeder@ira.uka.de>
References: <20090203130818.GA20359@neumann>
	<1233666531-21589-1-git-send-email-szeder@ira.uka.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org,
	=?utf-8?q?SZEDER=20G=C3=A1bor?= <szeder@ira.uka.de>
To: Jesse van den Kieboom <jesse@icecrew.nl>
X-From: git-owner@vger.kernel.org Tue Feb 03 14:10:58 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LUL3D-00033F-OB
	for gcvg-git-2@gmane.org; Tue, 03 Feb 2009 14:10:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753336AbZBCNI5 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 3 Feb 2009 08:08:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753348AbZBCNIz
	(ORCPT <rfc822;git-outgoing>); Tue, 3 Feb 2009 08:08:55 -0500
Received: from francis.fzi.de ([141.21.7.5]:23842 "EHLO exchange.fzi.de"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1752919AbZBCNIx (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Feb 2009 08:08:53 -0500
Received: from [127.0.1.1] ([141.21.4.196]) by exchange.fzi.de with Microsoft SMTPSVC(6.0.3790.3959);
	 Tue, 3 Feb 2009 14:08:50 +0100
X-Mailer: git-send-email 1.6.1.2.362.g0f78
In-Reply-To: <1233666531-21589-1-git-send-email-szeder@ira.uka.de>
X-OriginalArrivalTime: 03 Feb 2009 13:08:50.0773 (UTC) FILETIME=[8E9FD050:01C98600]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/108188>

=46or loading the xml UI files 'gitg-ui.xml' and 'gitg-menus.xml' the
same function call and error handling were performed twice.

This patch introduces a helper function to remove this code
duplication.

Signed-off-by: SZEDER G=C3=A1bor <szeder@ira.uka.de>
---

  Not sure about putting the new function into gitg-utils.c;  maybe it
  would be better in gitg.c...

 gitg/gitg-utils.c  |   16 ++++++++++++++++
 gitg/gitg-utils.h  |    2 ++
 gitg/gitg-window.c |   10 ++--------
 gitg/gitg.c        |    9 +--------
 4 files changed, 21 insertions(+), 16 deletions(-)

diff --git a/gitg/gitg-utils.c b/gitg/gitg-utils.c
index 5fb6772..cfce323 100644
--- a/gitg/gitg-utils.c
+++ b/gitg/gitg-utils.c
@@ -1,3 +1,4 @@
+#include <stdlib.h>
 #include <string.h>
 #include <glib.h>
=20
@@ -417,3 +418,18 @@ gitg_utils_menu_position_under_tree_view (GtkMenu =
 *menu,
 							tree);
 	}
 }
+
+void
+gitg_builder_add_from_file(GtkBuilder *builder, const gchar *filename)
+{
+	GError *error =3D NULL;
+	gchar full_filename[PATH_MAX];
+
+	g_snprintf(full_filename, PATH_MAX, "%s%c%s", GITG_UI_DIR, G_DIR_SEPA=
RATOR, filename);
+	if (!gtk_builder_add_from_file(builder, full_filename, &error))
+	{
+		g_critical("Could not open UI file: %s (%s)", full_filename, error->=
message);
+		g_error_free(error);
+		exit(1);
+	}
+}
diff --git a/gitg/gitg-utils.h b/gitg/gitg-utils.h
index 867fff7..46f8010 100644
--- a/gitg/gitg-utils.h
+++ b/gitg/gitg-utils.h
@@ -36,4 +36,6 @@ gint gitg_utils_sort_names(gchar const *s1, gchar con=
st *s2);
 void gitg_utils_menu_position_under_widget(GtkMenu *menu, gint *x, gin=
t *y,	gboolean *push_in, gpointer user_data);
 void gitg_utils_menu_position_under_tree_view(GtkMenu *menu, gint *x, =
gint *y, gboolean *push_in, gpointer user_data);
 					  =20
+void gitg_builder_add_from_file(GtkBuilder *builder, const gchar *file=
name);
+
 #endif /* __GITG_UTILS_H__ */
diff --git a/gitg/gitg-window.c b/gitg/gitg-window.c
index 8abdb9a..6f583d9 100644
--- a/gitg/gitg-window.c
+++ b/gitg/gitg-window.c
@@ -171,14 +171,8 @@ build_search_entry(GitgWindow *window, GtkBuilder =
*builder)
 =09
 	GtkBuilder *b =3D gtk_builder_new();
 	gtk_builder_set_translation_domain(b, GETTEXT_PACKAGE);
-	GError *error =3D NULL;
=20
-	if (!gtk_builder_add_from_file(b, GITG_UI_DIR "/gitg-menus.xml", &err=
or))
-	{
-		g_critical("Could not open UI file: %s (%s)", GITG_UI_DIR "/gitg-men=
us.xml", error->message);
-		g_error_free(error);
-		exit(1);
-	}
+	gitg_builder_add_from_file(b, "gitg-menus.xml");
 =09
 	GtkUIManager *manager =3D GTK_UI_MANAGER(gtk_builder_get_object(b, "u=
iman"));
 	window->priv->search_popup =3D GTK_WIDGET(g_object_ref(gtk_ui_manager=
_get_widget(manager, "/ui/search_popup")));
diff --git a/gitg/gitg.c b/gitg/gitg.c
index 69c5b56..20b9b53 100644
--- a/gitg/gitg.c
+++ b/gitg/gitg.c
@@ -52,17 +52,10 @@ on_window_delete_event(GtkWidget *widget, GdkEvent =
*event, gpointer userdata)
 static GitgWindow *
 build_ui()
 {
-	GError *error =3D NULL;
-=09
 	GtkBuilder *builder =3D gtk_builder_new();
 	gtk_builder_set_translation_domain(builder, GETTEXT_PACKAGE);
 =09
-	if (!gtk_builder_add_from_file(builder, GITG_UI_DIR "/gitg-ui.xml", &=
error))
-	{
-		g_critical("Could not open UI file: %s (%s)", GITG_UI_DIR "/gitg-ui.=
xml", error->message);
-		g_error_free(error);
-		exit(1);
-	}
+	gitg_builder_add_from_file(builder, "gitg-ui.xml");
 =09
 	GtkWidget *window =3D GTK_WIDGET(gtk_builder_get_object(builder, "win=
dow"));
 	gtk_widget_show_all(window);
--=20
1.6.1.2.362.g0f78
