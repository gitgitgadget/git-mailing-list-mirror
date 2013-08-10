From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH] push: respect --no-thin
Date: Sat, 10 Aug 2013 18:45:15 +0700
Message-ID: <20130810114515.GA14027@lanh>
References: <1376129407-30590-1-git-send-email-pclouds@gmail.com>
 <20130810103123.GB6237@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Martin Fick <mfick@codeaurora.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sat Aug 10 13:44:39 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V87b4-0006d2-Qg
	for gcvg-git-2@plane.gmane.org; Sat, 10 Aug 2013 13:44:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757682Ab3HJLof (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 10 Aug 2013 07:44:35 -0400
Received: from mail-pb0-f49.google.com ([209.85.160.49]:39270 "EHLO
	mail-pb0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757626Ab3HJLoe (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 10 Aug 2013 07:44:34 -0400
Received: by mail-pb0-f49.google.com with SMTP id xb4so5302507pbc.8
        for <git@vger.kernel.org>; Sat, 10 Aug 2013 04:44:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=S33eeo8KhY+KIhSgWT0diL1MwTlqQzRecpsuVdizoIM=;
        b=Oit0QHiAz6aDaEY3QK28xz9GvUJ4JfffAiFgHO7IdeEBmbJdAvRgjsnm0tPBDvQqsB
         hfxnXk8j+XSLI0kQDS87eQqKkHaJsa6Uh59dJAy6TaTLHsO7SkhD3PByKXc+BYfnAAYF
         YgY7RrsNocwpwZXi8oGw6vFS+DOr0M82OVizmEANNF2ISTn8f+dDlkFQDY4daHZY6F6g
         7ltH1Pg+vMXdR8I35peptZ01S8O/UVmrkt28UU/Wpd7O0lK/PPW/oixo5GCvFZNFyhKd
         VLs4ErVvHSm+BVaaolD1e467BXP6TbzEPY78NZHI3HGcNGHCcQbXqp94vCKouWpD0VBs
         dMHg==
X-Received: by 10.68.103.228 with SMTP id fz4mr15858699pbb.101.1376135073938;
        Sat, 10 Aug 2013 04:44:33 -0700 (PDT)
Received: from lanh ([115.73.210.38])
        by mx.google.com with ESMTPSA id sz3sm25542098pbc.5.2013.08.10.04.44.29
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sat, 10 Aug 2013 04:44:32 -0700 (PDT)
Received: by lanh (sSMTP sendmail emulation); Sat, 10 Aug 2013 18:45:15 +0700
Content-Disposition: inline
In-Reply-To: <20130810103123.GB6237@sigill.intra.peff.net>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/232092>

On Sat, Aug 10, 2013 at 06:31:23AM -0400, Jeff King wrote:
> It might be nice to have a test, but I am not sure of a good way to
> check whether a push was thin. I guess we can grep the output of
> GIT_TRACE, though it feels a bit hacky.

In theory, if we have a way to tell receive-pack not to pass
--fix-thin to index-pack, then it should barf on the thin pack
received from push/send-pack. But it does not work this way, or at
least I set up the test the wrong way, or pack-objects decides not to
create deltas.. anybody sees what's wrong in this test?

-- 8< --
diff --git a/builtin/receive-pack.c b/builtin/receive-pack.c
index e3eb5fc..da60817 100644
--- a/builtin/receive-pack.c
+++ b/builtin/receive-pack.c
@@ -38,6 +38,7 @@ static int quiet;
 static int prefer_ofs_delta = 1;
 static int auto_update_server_info;
 static int auto_gc = 1;
+static int fix_thin = 1;
 static const char *head_name;
 static void *head_name_to_free;
 static int sent_capabilities;
@@ -869,7 +870,8 @@ static const char *unpack(int err_fd)
 		keeper[i++] = "--stdin";
 		if (fsck_objects)
 			keeper[i++] = "--strict";
-		keeper[i++] = "--fix-thin";
+		if (fix_thin)
+			keeper[i++] = "--fix-thin";
 		keeper[i++] = hdr_arg;
 		keeper[i++] = keep_arg;
 		keeper[i++] = NULL;
@@ -975,6 +977,10 @@ int cmd_receive_pack(int argc, const char **argv, const char *prefix)
 				stateless_rpc = 1;
 				continue;
 			}
+			if (!strcmp(arg, "--no-thin")) {
+				fix_thin = 0;
+				continue;
+			}
 
 			usage(receive_pack_usage);
 		}
diff --git a/t/t5516-fetch-push.sh b/t/t5516-fetch-push.sh
index 4691d51..9c9d43c 100755
--- a/t/t5516-fetch-push.sh
+++ b/t/t5516-fetch-push.sh
@@ -126,6 +126,16 @@ test_expect_success setup '
 
 '
 
+test_expect_success 'push --no-thin' '
+	git init no-thin &&
+	git --git-dir=no-thin/.git config receive.unpacklimit 0 &&
+	git push no-thin/.git refs/heads/master:refs/heads/foo &&
+	echo modified >> path1 &&
+	git commit -am modified &&
+	git push --no-thin --receive-pack="git receive-pack --no-thin" no-thin/.git refs/heads/master:refs/heads/foo
+	false
+'
+
 test_expect_success 'fetch without wildcard' '
 	mk_empty testrepo &&
 	(
-- 8< --
