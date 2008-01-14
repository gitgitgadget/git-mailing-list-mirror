From: Kristian =?ISO-8859-1?Q?H=F8gsberg?= <krh@redhat.com>
Subject: Re: performance problem: "git commit filename"
Date: Mon, 14 Jan 2008 18:15:58 -0500
Message-ID: <1200352558.488.10.camel@gaara.boston.redhat.com>
References: <alpine.LFD.1.00.0801121426510.2806@woody.linux-foundation.org>
	 <alpine.LFD.1.00.0801121735020.2806@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Tue Jan 15 00:17:11 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JEYYI-0006SV-Vd
	for gcvg-git-2@gmane.org; Tue, 15 Jan 2008 00:17:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751064AbYANXQU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 14 Jan 2008 18:16:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752309AbYANXQU
	(ORCPT <rfc822;git-outgoing>); Mon, 14 Jan 2008 18:16:20 -0500
Received: from mx1.redhat.com ([66.187.233.31]:55105 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750851AbYANXQT (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Jan 2008 18:16:19 -0500
Received: from int-mx1.corp.redhat.com (int-mx1.corp.redhat.com [172.16.52.254])
	by mx1.redhat.com (8.13.8/8.13.8) with ESMTP id m0ENG320015611;
	Mon, 14 Jan 2008 18:16:03 -0500
Received: from pobox.corp.redhat.com (pobox.corp.redhat.com [10.11.255.20])
	by int-mx1.corp.redhat.com (8.13.1/8.13.1) with ESMTP id m0ENG3rH016835;
	Mon, 14 Jan 2008 18:16:03 -0500
Received: from [192.168.1.105] (dhcp83-9.boston.redhat.com [172.16.83.9])
	by pobox.corp.redhat.com (8.13.1/8.13.1) with ESMTP id m0ENG3aN013803;
	Mon, 14 Jan 2008 18:16:03 -0500
In-Reply-To: <alpine.LFD.1.00.0801121735020.2806@woody.linux-foundation.org>
X-Mailer: Evolution 2.21.4 (2.21.4-1.fc9) 
X-Scanned-By: MIMEDefang 2.58 on 172.16.52.254
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/70485>

On Sat, 2008-01-12 at 17:46 -0800, Linus Torvalds wrote:

> HOWEVER. When that logic was converted from that shell-script into a 
> builtin-commit.c, that conversion was not done correctly. The old "git 
> read-tree -i -m" was not translated as a "unpack_trees()" call, but as 
> this in prepare_index():
> 
> 	discard_cache()
> 	..
> 	tree = parse_tree_indirect(head_sha1);
> 	..
> 	read_tree(tree, 0, NULL)
> 
> which is very wrong, because it replaces the old index entirely, and 
> doesn't do that stat information merging.
> 
> As a result, the index that is created by read-tree is totally bogus in 
> the stat cache, and yes, everything will have to be re-computed.
> 
> Kristian?

Sorry for being late to the game, and yes, it's a bug I introduced with
the rewrite.  When doing the rewrite I was a bit puzzled by the

  git-read-tree --index-output="$TMP_INDEX" -i -m HEAD

part of the shell script.  I carried a FIXME around in the patch for a
while, as can be seen here:

  http://marc.info/?l=git&m=118478660425992&w=2

since I couldn't figure out what the difference in behavior was between
just using read_tree(), which did exactly what I wanted and the more
complicated unpack_tree().  I guess it fell through the cracks,
especially since it never caused the test suite to fail :/

Kristian
