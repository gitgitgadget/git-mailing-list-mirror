From: "Ping Yin" <pkufranky@gmail.com>
Subject: Re: [PATCH v2 2/3] builtin-status: submodule summary support
Date: Sat, 12 Apr 2008 13:28:22 +0800
Message-ID: <46dff0320804112228i557652b2kcad8fe524a9638ff@mail.gmail.com>
References: <1207841727-7840-1-git-send-email-pkufranky@gmail.com>
	 <1207841727-7840-2-git-send-email-pkufranky@gmail.com>
	 <1207841727-7840-3-git-send-email-pkufranky@gmail.com>
	 <7vtzi8owf9.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, "Johannes Sixt" <johannes.sixt@telecom.at>
To: "Junio C Hamano" <junio@pobox.com>
X-From: git-owner@vger.kernel.org Sat Apr 12 07:29:16 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JkYIV-0008U1-Oc
	for gcvg-git-2@gmane.org; Sat, 12 Apr 2008 07:29:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753353AbYDLF2Y (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 12 Apr 2008 01:28:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752958AbYDLF2X
	(ORCPT <rfc822;git-outgoing>); Sat, 12 Apr 2008 01:28:23 -0400
Received: from an-out-0708.google.com ([209.85.132.245]:5907 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752499AbYDLF2X (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 12 Apr 2008 01:28:23 -0400
Received: by an-out-0708.google.com with SMTP id d31so185444and.103
        for <git@vger.kernel.org>; Fri, 11 Apr 2008 22:28:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=3pmGH6aaEQgHJUtcTero7L4r+6CKkVdpT4LRIDlMSAY=;
        b=TTny+blM3afpCGVljxcQgUUlbmCv+WpaDcwZJ6on9vYHmk6+Ndokqu8QjTSbrhqmpjGrzj55TIQQnl5jab36bC7OYhtG3ABxgsJqrRJcpY4DeGGFntz+kcYe4DgTTXrSuquk+6URCqmEXIW0iWQwCSmd/RGVMF2mSFOIxbVW75o=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=ZcCr8ZZY7RyG7bgppKXqxSOKXfYylOoUumU/g0ZMKWsxSv1V+Vk8g9xLqkcwJYZA5ZuxsMhHYFNpGVxeL6Lbrwlynfne8Y8/ADbpdgfwIltmgzYoIrebcjHQXFNJo7Cr7Tr7XPuvJw2YIo1uO07CSwdWRut40reVkClG8EG7H74=
Received: by 10.101.67.15 with SMTP id u15mr6981067ank.19.1207978102306;
        Fri, 11 Apr 2008 22:28:22 -0700 (PDT)
Received: by 10.100.32.10 with HTTP; Fri, 11 Apr 2008 22:28:22 -0700 (PDT)
In-Reply-To: <7vtzi8owf9.fsf@gitster.siamese.dyndns.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/79333>

On Sat, Apr 12, 2008 at 6:31 AM, Junio C Hamano <junio@pobox.com> wrote:

>  int git_config_bool_or_int(const char *name, const char *value, int *is_bool)
>  {
>         *is_bool = 1;
>         if (!value)
>                 return 1;
>         if (!*value)
>                 return 0;
>         if (!strcasecmp(value, "true") || !strcasecmp(value, "yes"))
>                 return 1;
>         if (!strcasecmp(value, "false") || !strcasecmp(value, "no"))
>                 return 0;
>         *is_bool = 0;
>         return git_config_int(name, value) != 0;
>  }
>
>  With that, your configuration parser can do something like:
>
>
>         if (!strcmp(k, "status.submodulesummary")) {
>                 int is_bool, val;
>                 val = git_config_bool_or_int(k, v, &b);
>                 if (is_bool || val <= 0) {
>                         wt_status_submodule_summary_enabled = val;
>                 } else {
>                         wt_status_submodule_summary = val;
>                         wt_status_submodule_summary_enabled = 1;
>                 }
>         }
>
>  and skip the call to wt_status_print_submodule_summary() when not
>  enabled.
>
>
>  >  int wt_status_relative_paths = 1;
>  >  int wt_status_use_color = -1;
>  > +int wt_status_submodule_summary = -1; /* unspecified */
>   +int wt_status_submodule_summary_enabled;
>
>  The call site in wt_status_print() would look like:
>
>         ...
>
>         wt_status_print_changed(s);
>         if (wt_status_submodule_summary_enabled > 0)
>
>                 wt_status_print_submodule_summary(s);
>         wt_status_print_untracked(s);
>         ...
>

How about the following?

diff --git a/config.c b/config.c
index 0624494..e614456 100644
--- a/config.c
+++ b/config.c
@@ -316,6 +316,21 @@ int git_config_bool(const char *name, const char *value)
 	return git_config_int(name, value) != 0;
 }

+int git_config_bool_or_int(const char *name, const char *value, int *is_bool)
+{
+	*is_bool = 1;
+	if (!value)
+		return 1;
+	if (!*value)
+		return 0;
+	if (!strcasecmp(value, "true") || !strcasecmp(value, "yes"))
+		return 1;
+	if (!strcasecmp(value, "false") || !strcasecmp(value, "no"))
+		return 0;
+	*is_bool = 0;
+	return git_config_int(name, value);
+}
+
 int git_config_string(const char **dest, const char *var, const char *value)
 {
 	if (!value)
diff --git a/wt-status.c b/wt-status.c
index 22385f5..3baa128 100644
--- a/wt-status.c
+++ b/wt-status.c
@@ -366,7 +366,10 @@ void wt_status_print(struct wt_status *s)
 int git_status_config(const char *k, const char *v)
 {
 	if (!strcmp(k, "status.submodulesummary")) {
-		wt_status_submodule_summary = atoi(v);
+		int is_bool;
+		wt_status_submodule_summary = git_config_bool_or_int(k, v, &is_bool);
+		if (is_bool && wt_status_submodule_summary)
+			wt_status_submodule_summary = -1;
 		return 0;
 	}
 	if (!strcmp(k, "status.color") || !strcmp(k, "color.status")) {



-- 
Ping Yin
