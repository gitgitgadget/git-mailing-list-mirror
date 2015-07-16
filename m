From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Bug: send-pack does not respect http.signingkey
Date: Thu, 16 Jul 2015 13:06:36 -0700
Message-ID: <xmqqlhef50kz.fsf@gitster.dls.corp.google.com>
References: <CAD0k6qQ=ovEBZn_wje-exBhvW8brRbTgULDr68rmeiw-ZdsozQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git <git@vger.kernel.org>
To: Dave Borowitz <dborowitz@google.com>
X-From: git-owner@vger.kernel.org Thu Jul 16 22:06:47 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZFpQb-0002ag-VC
	for gcvg-git-2@plane.gmane.org; Thu, 16 Jul 2015 22:06:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753140AbbGPUGl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 16 Jul 2015 16:06:41 -0400
Received: from mail-ie0-f193.google.com ([209.85.223.193]:35181 "EHLO
	mail-ie0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751769AbbGPUGk (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 16 Jul 2015 16:06:40 -0400
Received: by iebmx2 with SMTP id mx2so4626995ieb.2
        for <git@vger.kernel.org>; Thu, 16 Jul 2015 13:06:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=wtBCvyFJ+r4bNbhxpvS/vZew7mH0cNHDHrcJCXAcWr4=;
        b=XSWuX2jtolH3qII6hzfak6AfnbWSuho3rpmgTHTMjzuIhXGHYw6Z+nRkLiUWx+2WpF
         +2HGLF2AlG2XK54ejfhnuyi7pQyTV3o//r55YWegEHQWlIG7/9BOoM/NylsJb5AORe4e
         yqis0s+xT1XK7q9HiaO/oxqHiWdb0fXT9Sze+fGoR5TXjhVkNIwF7kWIvzFq+nhSvMz3
         EuuoS27H+hjO9nHuEQHXoecs+IO6/gC11+gozzYAOIZINZDsfkyuhrq/wBMHTX33N2Y4
         cf8Ibf374tXQdW9UuZppZkyzR53ZI4uPVuHGLlS9njgRdFMEc7VigqAt5tVLMujtDGjf
         tR4w==
X-Received: by 10.107.10.17 with SMTP id u17mr13872977ioi.16.1437077199712;
        Thu, 16 Jul 2015 13:06:39 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:117b:74b0:a5d4:7d4c])
        by smtp.gmail.com with ESMTPSA id w4sm2001273igl.22.2015.07.16.13.06.38
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Thu, 16 Jul 2015 13:06:39 -0700 (PDT)
In-Reply-To: <CAD0k6qQ=ovEBZn_wje-exBhvW8brRbTgULDr68rmeiw-ZdsozQ@mail.gmail.com>
	(Dave Borowitz's message of "Thu, 16 Jul 2015 12:45:16 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/274039>

Dave Borowitz <dborowitz@google.com> writes:

> When git-send-pack is exec'ed, as is done by git-remote-http, it does
> not reread the config, so it does not respect the configured
> http.signingkey, either from the config file or -c on the command
> line. Thus it is currently impossible to specify a signing key over
> HTTP, other than the default one matching the "Name <email>" format in
> the keyring.
>
> This is not an issue for git:// as send-pack is executed directly in
> the same process that reads the config.

Interesting.  I agree that it would be a problem not to be able to
specify which signing key to use.

Perhaps something like this?

diff --git a/builtin/send-pack.c b/builtin/send-pack.c
index b564a77..57c3a9c 100644
--- a/builtin/send-pack.c
+++ b/builtin/send-pack.c
@@ -11,6 +11,7 @@
 #include "transport.h"
 #include "version.h"
 #include "sha1-array.h"
+#include "gpg-interface.h"
 
 static const char send_pack_usage[] =
 "git send-pack [--all | --mirror] [--dry-run] [--force] [--receive-pack=<git-receive-pack>] [--verbose] [--thin] [<host>:]<directory> [<ref>...]\n"
@@ -113,6 +114,8 @@ int cmd_send_pack(int argc, const char **argv, const char *prefix)
 	int from_stdin = 0;
 	struct push_cas_option cas = {0};
 
+	git_config(git_gpg_config, NULL);
+
 	argv++;
 	for (i = 1; i < argc; i++, argv++) {
 		const char *arg = *argv;
