From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH] editor: use canonicalized absolute path
Date: Tue, 30 Jul 2013 17:21:38 +0700
Message-ID: <20130730102138.GA30476@lanh>
References: <1375030782-13339-1-git-send-email-artagnon@gmail.com>
 <7v8v0p2z45.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Ramkumar Ramachandra <artagnon@gmail.com>,
	Git List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jul 30 12:21:15 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V473K-0007WM-N6
	for gcvg-git-2@plane.gmane.org; Tue, 30 Jul 2013 12:21:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755849Ab3G3KVK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 30 Jul 2013 06:21:10 -0400
Received: from mail-pd0-f181.google.com ([209.85.192.181]:40137 "EHLO
	mail-pd0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753441Ab3G3KVJ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 30 Jul 2013 06:21:09 -0400
Received: by mail-pd0-f181.google.com with SMTP id g10so2817901pdj.40
        for <git@vger.kernel.org>; Tue, 30 Jul 2013 03:21:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=g0hL2GPKRrpvkY1v79iXFpv47aRhQYjqcnyAyQGyJog=;
        b=SRjLdkYTueHAbrgY8onmxXU/wbggSA4T8BuFeOfgoMxK4kdYnhnFgPecK1xkhm0gte
         HeJrNhIEfbCuhPdtI51XDPwwDnXOuxRT3YuCF3dANmrFkxat7kguaGrZwH+MFsFcf//b
         thGaapGEEb241O646wBLNAh89bcMtaUj5hmrnJ3n7OVTO+4MP4A6n2A4C/S3S9zNTLRy
         8ZOrTZtR4unSdV2RVmIpseFZuKJYAHbZsbm0HL3sx5x5kOL6mHj2v3RREPofe6qVpB3h
         CHDwRfKMzZ4ClVhXn9hX02l7v9kkjKSL3DbVR1jRUTGwy5q1aY/lcUKHOmYRJoPnzs+6
         3DTQ==
X-Received: by 10.66.217.195 with SMTP id pa3mr23546706pac.120.1375179668406;
        Tue, 30 Jul 2013 03:21:08 -0700 (PDT)
Received: from lanh ([115.73.203.26])
        by mx.google.com with ESMTPSA id w8sm26209530paj.4.2013.07.30.03.21.05
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Tue, 30 Jul 2013 03:21:07 -0700 (PDT)
Received: by lanh (sSMTP sendmail emulation); Tue, 30 Jul 2013 17:21:38 +0700
Content-Disposition: inline
In-Reply-To: <7v8v0p2z45.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/231359>

On Mon, Jul 29, 2013 at 07:56:58AM -0700, Junio C Hamano wrote:
> > diff --git a/editor.c b/editor.c
> > index 27bdecd..0abbd8d 100644
> > --- a/editor.c
> > +++ b/editor.c
> > @@ -37,7 +37,7 @@ int launch_editor(const char *path, struct strbuf *buffer, const char *const *en
> >  		return error("Terminal is dumb, but EDITOR unset");
> >  
> >  	if (strcmp(editor, ":")) {
> > -		const char *args[] = { editor, path, NULL };
> > +		const char *args[] = { editor, real_path(path), NULL };
> 
> While I am not fundamentally opposed to add a workaround for bugs in
> a popular tool many people use, I am a bit uneasy about this change.
> 
> For editors that are not broken, this could be an annoying
> regression, isn't it?  When the user asks "What is the path of the
> file I am editing?" to the editor (i.e. an equivalent of \C-x\C-b),
> the updated code will start spewing a long full-path from the root
> directory, while we used to give a relative path that is short,
> sweet and more in line with the context of user's work.
> 
> Compared to not being able to edit, it may be a small price to pay
> for those who do need to suffer the broken editor, but the patch
> makes those who do not need this workaround to pay the price.
> 

How about something like this? For standard setups, even if you have
symlink in cwd, it won't kick in because the given path is usually
.git/something (i.e. no ".." component)

-- 8< --
diff --git a/editor.c b/editor.c
index 27bdecd..02bf42c 100644
--- a/editor.c
+++ b/editor.c
@@ -37,10 +37,17 @@ int launch_editor(const char *path, struct strbuf *buffer, const char *const *en
 		return error("Terminal is dumb, but EDITOR unset");
 
 	if (strcmp(editor, ":")) {
+		char cwd[PATH_MAX];
 		const char *args[] = { editor, path, NULL };
 		struct child_process p;
 		int ret, sig;
 
+		/* emacs workaround */
+		if (getcwd(cwd, PATH_MAX) &&
+		    strcmp(real_path(cwd), cwd) &&
+		    strstr(path, "../"))
+			args[1] = real_path(path);
+
 		memset(&p, 0, sizeof(p));
 		p.argv = args;
 		p.env = env;
-- 8<--
