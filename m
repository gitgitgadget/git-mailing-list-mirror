From: Stephen Boyd <bebarino@gmail.com>
Subject: Re: [PATCH/RFC 2/2] completion: allow use without compiling
Date: Tue, 27 Oct 2009 18:43:21 -0700
Message-ID: <4AE7A1B9.5010001@gmail.com>
References: <1256589116-6998-1-git-send-email-bebarino@gmail.com> <1256589116-6998-3-git-send-email-bebarino@gmail.com> <20091027185223.GH10505@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Clemens Buchacher <drizzd@aon.at>,
	Sverre Rabbelier <srabbelier@gmail.com>
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Wed Oct 28 02:44:28 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N2xa5-00043E-07
	for gcvg-git-2@lo.gmane.org; Wed, 28 Oct 2009 02:44:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756848AbZJ1Bns (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 27 Oct 2009 21:43:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756073AbZJ1Bns
	(ORCPT <rfc822;git-outgoing>); Tue, 27 Oct 2009 21:43:48 -0400
Received: from ey-out-2122.google.com ([74.125.78.24]:28082 "EHLO
	ey-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756034AbZJ1Bnr (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Oct 2009 21:43:47 -0400
Received: by ey-out-2122.google.com with SMTP id 9so103103eyd.19
        for <git@vger.kernel.org>; Tue, 27 Oct 2009 18:43:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from
         :user-agent:mime-version:to:cc:subject:references:in-reply-to
         :content-type:content-transfer-encoding;
        bh=QEM+2dp2hIbsUiLdj5WudLVUokDS5zEp2yWc9Wp+h9M=;
        b=b6+pYnmG7+xO3lkANe1hl/kc3FPkYloPDqhUGwMcoTxcTaaVe8X8PHoi2WpnJsOWHA
         Ufpy2sUl+3m/82W4hLlzVMWOpejCuUkXvoRKapBcG7bn3PDRZMY35hgSShNaKlTjdqda
         BiFBikjbXES51TVc51C4Hb0Ks1VtCz14TqUcI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        b=EWvEqGn6Bw0jP792DywhF8EtW4L8NBE5mCvpJPcFJkkNNIzaBT5meltEWG3Ar3aDS6
         536HBwIxdpkBtXxHtK5G1+IbOMv7+eB+gecQ36OyhJKYVx8MhALAffg8zBpKZNf0rjGI
         Ss8L1znTlYQoPvqctuzFX6d1dhHpbtzng+hR0=
Received: by 10.211.154.18 with SMTP id g18mr12333638ebo.70.1256694230961;
        Tue, 27 Oct 2009 18:43:50 -0700 (PDT)
Received: from ?192.168.0.5? (cpe-76-174-15-88.socal.res.rr.com [76.174.15.88])
        by mx.google.com with ESMTPS id 28sm65431eye.7.2009.10.27.18.43.47
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 27 Oct 2009 18:43:49 -0700 (PDT)
User-Agent: Thunderbird 2.0.0.23 (X11/20091026)
In-Reply-To: <20091027185223.GH10505@spearce.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/131399>

Shawn O. Pearce wrote:
> NAK on code duplication, especially this much.  As Junio already
> pointed out in this thread we need an approach that doesn't cause
> this sort of redundant code.

Ok. Following Junio's suggestion I think we would have to do the following:

(1) Revert the rename (git-completion.bash.in -> git-completion.bash)

(2) Add a "generation" mode to git-completion.bash.generate to generate 
the lists and output them to a file

(3) Add logic in git-completion.bash.generate to source the generated 
file if it exists

(4) Source git-completion.bash.generate in git-completion.bash to get 
the functions moved there

In the end we would have git-completion.bash sourcing 
git-completion.bash.generate which then sources the generated file. I 
assume this is slower than compiling to just one file.

Or we could just not load the caches until they're needed. This just 
delays the performance hit to completion time, but at least it speeds up 
loading the script without the need to compile and still has the benefit 
of some caching. It also allows users to keep the completion of their 
custom merge strategies and git programs in their PATH.

----8<----

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index d3fec32..8a7cde3 100755
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -326,10 +326,15 @@ __git_remotes ()
 
 __git_merge_strategies ()
 {
-	if [ -n "${__git_merge_strategylist-}" ]; then
+	if [ -n "${__git_merge_strategylist-}" ] || {
+		__git_merge_strategylist=$(__git_merge_strategies_gen 2>/dev/null)
+	}; then
 		echo "$__git_merge_strategylist"
-		return
 	fi
+}
+
+__git_merge_strategies_gen ()
+{
 	git merge -s help 2>&1 |
 	sed -n -e '/[Aa]vailable strategies are: /,/^$/{
 		s/\.$//
@@ -340,7 +345,6 @@ __git_merge_strategies ()
 	}'
 }
 __git_merge_strategylist=
-__git_merge_strategylist=$(__git_merge_strategies 2>/dev/null)
 
 __git_complete_file ()
 {
@@ -491,10 +495,15 @@ __git_complete_strategy ()
 
 __git_all_commands ()
 {
-	if [ -n "${__git_all_commandlist-}" ]; then
+	if [ -n "${__git_all_commandlist-}" ] || {
+		__git_all_commandlist="$(__git_all_commands_gen 2>/dev/null)"
+	}; then
 		echo "$__git_all_commandlist"
-		return
 	fi
+}
+
+__git_all_commands_gen ()
+{
 	local i IFS=" "$'\n'
 	for i in $(git help -a|egrep '^  [a-zA-Z0-9]')
 	do
@@ -505,14 +514,18 @@ __git_all_commands ()
 	done
 }
 __git_all_commandlist=
-__git_all_commandlist="$(__git_all_commands 2>/dev/null)"
 
 __git_porcelain_commands ()
 {
-	if [ -n "${__git_porcelain_commandlist-}" ]; then
+	if [ -n "${__git_porcelain_commandlist-}" ] || {
+		__git_porcelain_commandlist="$(__git_porcelain_commands_gen 2>/dev/null)"
+	}; then
 		echo "$__git_porcelain_commandlist"
-		return
 	fi
+}
+
+__git_porcelain_commands_gen ()
+{
 	local i IFS=" "$'\n'
 	for i in "help" $(__git_all_commands)
 	do
@@ -596,7 +609,6 @@ __git_porcelain_commands ()
 	done
 }
 __git_porcelain_commandlist=
-__git_porcelain_commandlist="$(__git_porcelain_commands 2>/dev/null)"
 
 __git_aliases ()
 {
