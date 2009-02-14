From: Jesse van den Kieboom <jesse@icecrew.nl>
Subject: Re: [PATCH 2/3] Refactor loading xml UI files
Date: Sat, 14 Feb 2009 22:37:42 +0100
Message-ID: <B4F11616-9BC8-4572-B8EC-8F8E3AF0619B@icecrew.nl>
References: <20090203130818.GA20359@neumann> <1233666531-21589-1-git-send-email-szeder@ira.uka.de> <1233666531-21589-2-git-send-email-szeder@ira.uka.de>
Mime-Version: 1.0 (Apple Message framework v929.2)
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed	delsp=yes
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?ISO-8859-1?Q?SZEDER_G=E1bor?= <szeder@ira.uka.de>
X-From: git-owner@vger.kernel.org Sat Feb 14 22:39:16 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LYSEE-00024t-Vb
	for gcvg-git-2@gmane.org; Sat, 14 Feb 2009 22:39:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752477AbZBNVhs convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 14 Feb 2009 16:37:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752326AbZBNVhr
	(ORCPT <rfc822;git-outgoing>); Sat, 14 Feb 2009 16:37:47 -0500
Received: from novowork.com ([87.230.85.62]:40043 "EHLO novowork.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752183AbZBNVhq convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 14 Feb 2009 16:37:46 -0500
Received: from [192.168.3.100] (217-162-71-67.dclient.hispeed.ch [217.162.71.67])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by novowork.com (Postfix) with ESMTPSA id 2147F12D9418E;
	Sat, 14 Feb 2009 22:37:44 +0100 (CET)
In-Reply-To: <1233666531-21589-2-git-send-email-szeder@ira.uka.de>
X-Mailer: Apple Mail (2.929.2)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/109937>

Op 3 feb 2009, om 14:08 heeft SZEDER G=E1bor het volgende geschreven:

> For loading the xml UI files 'gitg-ui.xml' and 'gitg-menus.xml' the
> same function call and error handling were performed twice.
>
> This patch introduces a helper function to remove this code
> duplication.
>

Thanks, I committed this (slightly altered)

> Signed-off-by: SZEDER G=E1bor <szeder@ira.uka.de>
> ---
>
>  Not sure about putting the new function into gitg-utils.c;  maybe it
>  would be better in gitg.c...
>
> gitg/gitg-utils.c  |   16 ++++++++++++++++
> gitg/gitg-utils.h  |    2 ++
> gitg/gitg-window.c |   10 ++--------
> gitg/gitg.c        |    9 +--------
> 4 files changed, 21 insertions(+), 16 deletions(-)
>
> diff --git a/gitg/gitg-utils.c b/gitg/gitg-utils.c
> index 5fb6772..cfce323 100644
> --- a/gitg/gitg-utils.c
> +++ b/gitg/gitg-utils.c
> @@ -1,3 +1,4 @@
> +#include <stdlib.h>
> #include <string.h>
> #include <glib.h>
>
> @@ -417,3 +418,18 @@ gitg_utils_menu_position_under_tree_view =20
> (GtkMenu  *menu,
> 							tree);
> 	}
> }
> +
> +void
> +gitg_builder_add_from_file(GtkBuilder *builder, const gchar =20
> *filename)
> +{
> +	GError *error =3D NULL;
> +	gchar full_filename[PATH_MAX];
> +
> +	g_snprintf(full_filename, PATH_MAX, "%s%c%s", GITG_UI_DIR, =20
> G_DIR_SEPARATOR, filename);
> +	if (!gtk_builder_add_from_file(builder, full_filename, &error))
> +	{
> +		g_critical("Could not open UI file: %s (%s)", full_filename, =20
> error->message);
> +		g_error_free(error);
> +		exit(1);
> +	}
> +}
> diff --git a/gitg/gitg-utils.h b/gitg/gitg-utils.h
> index 867fff7..46f8010 100644
> --- a/gitg/gitg-utils.h
> +++ b/gitg/gitg-utils.h
> @@ -36,4 +36,6 @@ gint gitg_utils_sort_names(gchar const *s1, gchar =20
> const *s2);
> void gitg_utils_menu_position_under_widget(GtkMenu *menu, gint *x, =20
> gint *y,	gboolean *push_in, gpointer user_data);
> void gitg_utils_menu_position_under_tree_view(GtkMenu *menu, gint =20
> *x, gint *y, gboolean *push_in, gpointer user_data);
> 				=09
> +void gitg_builder_add_from_file(GtkBuilder *builder, const gchar =20
> *filename);
> +
> #endif /* __GITG_UTILS_H__ */
> diff --git a/gitg/gitg-window.c b/gitg/gitg-window.c
> index 8abdb9a..6f583d9 100644
> --- a/gitg/gitg-window.c
> +++ b/gitg/gitg-window.c
> @@ -171,14 +171,8 @@ build_search_entry(GitgWindow *window, =20
> GtkBuilder *builder)
> =09
> 	GtkBuilder *b =3D gtk_builder_new();
> 	gtk_builder_set_translation_domain(b, GETTEXT_PACKAGE);
> -	GError *error =3D NULL;
>
> -	if (!gtk_builder_add_from_file(b, GITG_UI_DIR "/gitg-menus.xml", =20
> &error))
> -	{
> -		g_critical("Could not open UI file: %s (%s)", GITG_UI_DIR "/gitg-=20
> menus.xml", error->message);
> -		g_error_free(error);
> -		exit(1);
> -	}
> +	gitg_builder_add_from_file(b, "gitg-menus.xml");
> =09
> 	GtkUIManager *manager =3D GTK_UI_MANAGER(gtk_builder_get_object(b, =20
> "uiman"));
> 	window->priv->search_popup =3D =20
> GTK_WIDGET(g_object_ref(gtk_ui_manager_get_widget(manager, "/ui/=20
> search_popup")));
> diff --git a/gitg/gitg.c b/gitg/gitg.c
> index 69c5b56..20b9b53 100644
> --- a/gitg/gitg.c
> +++ b/gitg/gitg.c
> @@ -52,17 +52,10 @@ on_window_delete_event(GtkWidget *widget, =20
> GdkEvent *event, gpointer userdata)
> static GitgWindow *
> build_ui()
> {
> -	GError *error =3D NULL;
> -=09
> 	GtkBuilder *builder =3D gtk_builder_new();
> 	gtk_builder_set_translation_domain(builder, GETTEXT_PACKAGE);
> =09
> -	if (!gtk_builder_add_from_file(builder, GITG_UI_DIR "/gitg-=20
> ui.xml", &error))
> -	{
> -		g_critical("Could not open UI file: %s (%s)", GITG_UI_DIR "/gitg-=20
> ui.xml", error->message);
> -		g_error_free(error);
> -		exit(1);
> -	}
> +	gitg_builder_add_from_file(builder, "gitg-ui.xml");
> =09
> 	GtkWidget *window =3D GTK_WIDGET(gtk_builder_get_object(builder, =20
> "window"));
> 	gtk_widget_show_all(window);
> --=20
> 1.6.1.2.362.g0f78
>
