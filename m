From: Paul Tan <pyokagan@gmail.com>
Subject: [PATCH v2 1/7] path.c: implement xdg_config_home()
Date: Wed, 15 Apr 2015 01:28:54 +0800
Message-ID: <20150414172854.GA27623@yoshi.chippynet.com>
References: <1428824772-8736-1-git-send-email-pyokagan@gmail.com>
 <e1bc6f19af608db796a2212dbf00ba45@www.dscho.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Stefan Beller <sbeller@google.com>
To: Johannes Schindelin <johannes.schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Tue Apr 14 19:29:20 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Yi4eD-0001nY-TB
	for gcvg-git-2@plane.gmane.org; Tue, 14 Apr 2015 19:29:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933116AbbDNR3N (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 14 Apr 2015 13:29:13 -0400
Received: from mail-pd0-f170.google.com ([209.85.192.170]:33283 "EHLO
	mail-pd0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932426AbbDNR3M (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 14 Apr 2015 13:29:12 -0400
Received: by pdbnk13 with SMTP id nk13so19560353pdb.0
        for <git@vger.kernel.org>; Tue, 14 Apr 2015 10:29:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=+0myjndLO/NmmH3JmGV4Z68g1C86vKGt1/BwEu037uQ=;
        b=ZX0Tf9rbEhHrdHZOjS8YoVDfypPwtTPCkOd/U5mrVFmTMQ/OpXUd9qWQWWMqAOCmsr
         ohPFYp3mVcyRr4xVwODrBsUPlSKP/9WT8VSOT5CIwypEhDQOriqT1q99fWKtP3OE/Fkl
         qG7Zg4fkig7NaPWLRwxPv1S+WlERJiweJGdX0NSLln7Q1XPOEXLcyHZV3ZTeYuxy0HJK
         uHPJ1s+cFN8zN5asy+tkhzcP7hYtoub2t8+eBq0SX8r8QeMkd7qlTquI+9a38h2joD8W
         CUUByfRQpmfmX8cINZGziJsD6r/4jGI9nOCsIbcHZMsambGkGvjbFFtrrZ8cOJRVrVol
         A2CQ==
X-Received: by 10.68.180.195 with SMTP id dq3mr38775152pbc.39.1429032552109;
        Tue, 14 Apr 2015 10:29:12 -0700 (PDT)
Received: from yoshi.chippynet.com ([116.86.172.217])
        by mx.google.com with ESMTPSA id fl4sm1695293pab.8.2015.04.14.10.28.56
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 14 Apr 2015 10:29:11 -0700 (PDT)
Received: from pyokagan by yoshi.chippynet.com with local (Exim 4.84)
	(envelope-from <pyokagan@yoshi.chippynet.com>)
	id 1Yi4dq-0008Ox-64; Wed, 15 Apr 2015 01:28:54 +0800
Content-Disposition: inline
In-Reply-To: <e1bc6f19af608db796a2212dbf00ba45@www.dscho.org>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/267152>

Hi,

On Mon, Apr 13, 2015 at 05:50:49PM +0200, Johannes Schindelin wrote:
> maybe it would be a good idea to add a `0/7` mail that describes the
> overall goal of this patch series, much like a Pull Request? I found
> it very useful -- even for myself -- to set a description via `git
> branch --edit-description` and to let `git format-patch` use that via
> the `--cover-letter` option.

In this case I felt that the first patch's commit message was
descriptive enough and a cover message would simply repeat it.

> below just two minor nits because the rest of the patches looks fine to me:
> 
> On 2015-04-12 09:46, Paul Tan wrote:
> > diff --git a/cache.h b/cache.h
> > index 3d3244b..7f9bab0 100644
> > --- a/cache.h
> > +++ b/cache.h
> > @@ -836,6 +836,13 @@ char *strip_path_suffix(const char *path, const
> > char *suffix);
> >  int daemon_avoid_alias(const char *path);
> >  extern int is_ntfs_dotgit(const char *name);
> >  
> > +/**
> > + * Returns the newly allocated string "$XDG_CONFIG_HOME/git/%s".  If
> > + * $XDG_CONFIG_HOME is unset or empty, returns the newly allocated string
> > + * "$HOME/.config/git/%s". Returns NULL if an error occurred.
> > + */
> > +extern char *xdg_config_home(const char *fn);
> 
> Should this not be inserted close to home_config_paths()?

A personal style thing, but I wanted to add the function's docstring to
cache.h (where I personally think it belongs), but I didn't want to
break up the huge block of path function declarations. Hence, it was
added at the end.

> Also, the name "fn" sounds more like "function" than like "filename"
> to me, especially keeping the name `config_fn_t` in mind. Maybe call
> the parameter "filename" to avoid confusion?

That's true, especially since there is still lots of horizontal space
for this name.

Below is the fixed patch. I also decided to return NULL if `filename` is
NULL because such an input usually indicated an uncaught error. The
docstring has also been modified to be a little clearer.

Thanks all for the reviews.

---- >8 ----
The XDG base dir spec[1] specifies that configuration files be stored in
a subdirectory in $XDG_CONFIG_HOME. To construct such a configuration
file path, home_config_paths() can be used. However, home_config_paths()
combines distinct functionality:

1. Retrieve the home git config file path ~/.gitconfig

2. Construct the XDG config path of the file specified by `file`.

This function was introduced in commit 21cf3227 ("read (but not write)
from $XDG_CONFIG_HOME/git/config file").  While the intention of the
function was to allow the home directory configuration file path and the
xdg directory configuration file path to be retrieved with one function
call, the hard-coding of the path ~/.gitconfig prevents it from being
used for other configuration files. Furthermore, retrieving a file path
relative to the user's home directory can be done with
expand_user_path(). Hence, it can be seen that home_config_paths()
introduces unnecessary complexity, especially if a user just wants to
retrieve the xdg config file path.

As such, implement a simpler function xdg_config_home() for constructing
the XDG base dir spec configuration file path. This function, together
with expand_user_path(), can replace all uses of home_config_paths().

[1] http://standards.freedesktop.org/basedir-spec/basedir-spec-0.7.html

Signed-off-by: Paul Tan <pyokagan@gmail.com>
---
 cache.h |  8 ++++++++
 path.c  | 16 ++++++++++++++++
 2 files changed, 24 insertions(+)

diff --git a/cache.h b/cache.h
index 3d3244b..2db10b8 100644
--- a/cache.h
+++ b/cache.h
@@ -836,6 +836,14 @@ char *strip_path_suffix(const char *path, const char *suffix);
 int daemon_avoid_alias(const char *path);
 extern int is_ntfs_dotgit(const char *name);
 
+/**
+ * Returns the newly allocated string "$XDG_CONFIG_HOME/git/{filename}".  If
+ * $XDG_CONFIG_HOME is unset or empty, returns the newly allocated string
+ * "$HOME/.config/git/{filename}". Returns NULL if filename is NULL or an error
+ * occurred.
+ */
+extern char *xdg_config_home(const char *filename);
+
 /* object replacement */
 #define LOOKUP_REPLACE_OBJECT 1
 extern void *read_sha1_file_extended(const unsigned char *sha1, enum object_type *type, unsigned long *size, unsigned flag);
diff --git a/path.c b/path.c
index e608993..8ee7191 100644
--- a/path.c
+++ b/path.c
@@ -856,3 +856,19 @@ int is_ntfs_dotgit(const char *name)
 			len = -1;
 		}
 }
+
+char *xdg_config_home(const char *filename)
+{
+	const char *config_home = getenv("XDG_CONFIG_HOME");
+
+	if (!filename)
+		return NULL;
+	if (!config_home || !config_home[0]) {
+		const char *home = getenv("HOME");
+
+		if (!home)
+			return NULL;
+		return mkpathdup("%s/.config/git/%s", home, filename);
+	} else
+		return mkpathdup("%s/git/%s", config_home, filename);
+}
-- 
2.1.4
