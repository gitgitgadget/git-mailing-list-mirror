From: Paul Tan <pyokagan@gmail.com>
Subject: [PATCH v3 1/7] path.c: implement xdg_config_home()
Date: Tue, 21 Apr 2015 12:06:27 +0800
Message-ID: <20150421040627.GA5415@yoshi.chippynet.com>
References: <1428824772-8736-1-git-send-email-pyokagan@gmail.com>
 <e1bc6f19af608db796a2212dbf00ba45@www.dscho.org>
 <20150414172854.GA27623@yoshi.chippynet.com>
 <CAPig+cTrErOBwPteeA1d_gdve5SiyLnbyFPpQ1sTN7aajGJfeA@mail.gmail.com>
 <CACRoPnR7MQsP_dAE0RV_80JDbU9h6tfu30yL2OOK+JGYLzVLNQ@mail.gmail.com>
 <CAPig+cQD9BH8kib98fCsiUHnsSAAMkwxAnFVxD8Gq5JMwXVjog@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Schindelin <johannes.schindelin@gmx.de>,
	Git List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Stefan Beller <sbeller@google.com>
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Tue Apr 21 06:06:45 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YkPSO-00008O-OF
	for gcvg-git-2@plane.gmane.org; Tue, 21 Apr 2015 06:06:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752421AbbDUEGh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 21 Apr 2015 00:06:37 -0400
Received: from mail-pd0-f170.google.com ([209.85.192.170]:36614 "EHLO
	mail-pd0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752364AbbDUEGf (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 21 Apr 2015 00:06:35 -0400
Received: by pdea3 with SMTP id a3so229040305pde.3
        for <git@vger.kernel.org>; Mon, 20 Apr 2015 21:06:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=IvZEG7lryGw+E3QVBEOgSZhuLW9r10TPoT0Cr4WIsHE=;
        b=f7iwh3qp4yOXLmjid+VDGiChOYdbCB7gkqrz8GdM0b28/xZ16hSlbSGIH9juIibMps
         DQWiONhcAm0atoaZNYPQiut6NrvBz7m5sh2dZwcDg8AHpWtXOHfUD+lnIRm2YM6/f1kl
         nRo7pqCuaWdbQWFI0lSv5nHgiMNP4yqT9i5Wop0+86VsC/nrt/Mk2Wm3+noKw/XCQPwO
         Ykz35i7I/Ay46MR5M3Cn6fmZIdzYFfcLsLNLw46wLiOSGen4lJtr4JDH4xnuwJ8ph30p
         iwbn6bZRsuSvMCuWfH01vBuQVI+D+DgWW9EpEoGNsq/GxgB3UsamqUrnGEBiHS9ax4ST
         ePHw==
X-Received: by 10.68.65.106 with SMTP id w10mr33337044pbs.75.1429589194513;
        Mon, 20 Apr 2015 21:06:34 -0700 (PDT)
Received: from yoshi.chippynet.com ([116.86.172.217])
        by mx.google.com with ESMTPSA id z5sm459906pbt.54.2015.04.20.21.06.31
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 20 Apr 2015 21:06:32 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <CAPig+cQD9BH8kib98fCsiUHnsSAAMkwxAnFVxD8Gq5JMwXVjog@mail.gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/267518>

Hi,

On Sun, Apr 19, 2015 at 08:39:44PM -0400, Eric Sunshine wrote:
> Other than being enuinely confused by the original, and having to
> check the actual implementation for clarification, I don't feel
> strongly about it either. Perhaps mentioning "evaluation" like this
> might help?
> 
>     Return a newly allocated string with the evaluation of
>     "$XDG_CONFIG_HOME/git/$filename" if $XDG_CONFIG_HOME is
>     non-empty, otherwise "$HOME/.config/git/$filename". Return
>     NULL upon error.
> 

This is perfect, thanks.

Re-rolled patch below now uses assert() to check if filename is
non-NULL, and re-arranges the control flow.

--- >8 ---

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

Helped-by: Eric Sunshine <sunshine@sunshineco.com>
Signed-off-by: Paul Tan <pyokagan@gmail.com>
---
 cache.h |  7 +++++++
 path.c  | 15 +++++++++++++++
 2 files changed, 22 insertions(+)

diff --git a/cache.h b/cache.h
index 3d3244b..3512d32 100644
--- a/cache.h
+++ b/cache.h
@@ -836,6 +836,13 @@ char *strip_path_suffix(const char *path, const char *suffix);
 int daemon_avoid_alias(const char *path);
 extern int is_ntfs_dotgit(const char *name);
 
+/**
+ * Return a newly allocated string with the evaluation of
+ * "$XDG_CONFIG_HOME/git/$filename" if $XDG_CONFIG_HOME is non-empty, otherwise
+ * "$HOME/.config/git/$filename". Return NULL upon error.
+ */
+extern char *xdg_config_home(const char *filename);
+
 /* object replacement */
 #define LOOKUP_REPLACE_OBJECT 1
 extern void *read_sha1_file_extended(const unsigned char *sha1, enum object_type *type, unsigned long *size, unsigned flag);
diff --git a/path.c b/path.c
index 595da81..c28b8f5 100644
--- a/path.c
+++ b/path.c
@@ -851,3 +851,18 @@ int is_ntfs_dotgit(const char *name)
 			len = -1;
 		}
 }
+
+char *xdg_config_home(const char *filename)
+{
+	const char *home, *config_home;
+
+	assert(filename);
+	config_home = getenv("XDG_CONFIG_HOME");
+	if (config_home && *config_home)
+		return mkpathdup("%s/git/%s", config_home, filename);
+
+	home = getenv("HOME");
+	if (home)
+		return mkpathdup("%s/.config/git/%s", home, filename);
+	return NULL;
+}
-- 
2.1.4
