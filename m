From: "Brandon Casey" <drafnel@gmail.com>
Subject: Re: [PATCH 1/3] repack: modify behavior of -A option to leave unreferenced objects unpacked
Date: Sat, 10 May 2008 23:51:41 -0500
Message-ID: <ee63ef30805102151r54121e46n4aac3f951077b4fd@mail.gmail.com>
References: <7vabj0b1re.fsf@gitster.siamese.dyndns.org>
	 <3927888.1210392047922.JavaMail.teamon@b303.teamon.com>
	 <20080510060345.GC11556@sigill.intra.peff.net>
	 <ee63ef30805102116m68e83fadr8ef9afb080d26cf0@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: gitster@pobox.com, git@vger.kernel.org
To: "Jeff King" <peff@peff.net>
X-From: git-owner@vger.kernel.org Sun May 11 06:53:05 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jv3YW-0000M3-8K
	for gcvg-git-2@gmane.org; Sun, 11 May 2008 06:53:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750749AbYEKEvt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 11 May 2008 00:51:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750710AbYEKEvt
	(ORCPT <rfc822;git-outgoing>); Sun, 11 May 2008 00:51:49 -0400
Received: from fg-out-1718.google.com ([72.14.220.153]:58993 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750709AbYEKEvs (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 11 May 2008 00:51:48 -0400
Received: by fg-out-1718.google.com with SMTP id 19so1350347fgg.17
        for <git@vger.kernel.org>; Sat, 10 May 2008 21:51:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=WgOCu5EHbbYamDY94XKzyXqTuY//jeXHo8ElU2zex5o=;
        b=TUvPYxjM06N1hAReDgstiJShxoXMC5NbNpWbqmgT7qR5IxRxUvRX6AhM7n8w5nPt+EAWEpuBeqwtQIppiRt+ZD7tiZxky+aHgM3erglvTtJluCXWzS3GvMZn5vVPv00tJ4Lww9lJ2NL+G8+v0D1OE790HArroXMZWqq7ndFsK+I=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=ZA+pasEHLXC91xDjL6pl2v9sURbTtkWIvSMMvxmVYuoI5GbSjHnPJxsGMuahFMGxiLLvkzWM30lfiKbfw5xqyMDXVDKBXZm+wVk2MBokK7kVmbb4lU5HLczR3Z5imzkbv/ZlDOgebi8T6TqxpcqkXTNw3Itc6P4wvk7eXWBjYTY=
Received: by 10.86.89.4 with SMTP id m4mr11720794fgb.16.1210481501081;
        Sat, 10 May 2008 21:51:41 -0700 (PDT)
Received: by 10.86.89.8 with HTTP; Sat, 10 May 2008 21:51:41 -0700 (PDT)
In-Reply-To: <ee63ef30805102116m68e83fadr8ef9afb080d26cf0@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/81731>

On Sat, May 10, 2008 at 11:16 PM, Brandon Casey <drafnel@gmail.com> wrote:

> I've got a thought. How about limiting how often auto repack repacks
> by looking at the timestamp of the most recent pack? Wouldn't the
> packs already be prepared in most cases i.e. prepare_packed_git()

completely untested and hopefully not mangled by google...

actually, this will do nothing for the case where there exists many
loose unreachable objects and no loose reachable objects since we
won't create a new pack with an updated timestamp to compare against.
So git-gc will continue to spin its wheels without getting anywhere.
Could we update the pack timestamp after running git-gc or use a
timestamp from someplace else?

-brandon

diff --git a/builtin-gc.c b/builtin-gc.c
index 48f7d95..16b1455 100644
--- a/builtin-gc.c
+++ b/builtin-gc.c
@@ -27,6 +27,7 @@ static int aggressive_window = -1;
 static int gc_auto_threshold = 6700;
 static int gc_auto_pack_limit = 50;
 static char *prune_expire = "2.weeks.ago";
+static time_t gc_auto_pack_frequency = 21600;  /* 6 hours */

 #define MAX_ADD 10
 static const char *argv_pack_refs[] = {"pack-refs", "--all", "--prune", NULL};
@@ -56,6 +57,10 @@ static int gc_config(const char *var, const char *value)
                gc_auto_pack_limit = git_config_int(var, value);
                return 0;
        }
+       if (!strcmp(var, "gc.autopackfrequency")) {
+               gc_auto_pack_frequency = git_config_ulong(var, value);
+               return 0;
+       }
        if (!strcmp(var, "gc.pruneexpire")) {
                if (!value)
                        return config_error_nonbool(var);
@@ -205,6 +210,14 @@ static int need_to_gc(void)
        else if (!too_many_loose_objects())
                return 0;

+       if (gc_auto_pack_frequency) {
+               prepare_packed_git();
+               if (packed_git &&
+                   packed_git->mtime >
+                   approxidate("now") - gc_auto_pack_frequency)
+                       return 0;
+       }
+
        if (run_hook())
                return 0;
        return 1;
