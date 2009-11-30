From: Nanako Shiraishi <nanako3@lavabit.com>
Subject: Re: equal-tree-merges as way to make rebases fast-forward-able
Date: Tue, 01 Dec 2009 07:12:34 +0900
Message-ID: <20091201071234.6117@nanako3.lavabit.com>
References: <cover.1259524136.git.brlink@debian.org> <7v8wdnooza.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: "Bernhard R. Link" <brlink@debian.org>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Nov 30 23:12:53 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NFEUG-0001qz-TA
	for gcvg-git-2@lo.gmane.org; Mon, 30 Nov 2009 23:12:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752477AbZK3WMl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 30 Nov 2009 17:12:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752274AbZK3WMk
	(ORCPT <rfc822;git-outgoing>); Mon, 30 Nov 2009 17:12:40 -0500
Received: from karen.lavabit.com ([72.249.41.33]:44772 "EHLO karen.lavabit.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751098AbZK3WMk (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 30 Nov 2009 17:12:40 -0500
Received: from b.earth.lavabit.com (b.earth.lavabit.com [192.168.111.11])
	by karen.lavabit.com (Postfix) with ESMTP id D764811B80E;
	Mon, 30 Nov 2009 16:12:46 -0600 (CST)
Received: from 5185.lavabit.com (212.62.97.20)
	by lavabit.com with ESMTP id AZK0LM7V9W78; Mon, 30 Nov 2009 16:12:46 -0600
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws; s=lavabit; d=lavabit.com;
  b=W9i20eqUFerkC9Ia1NSR5GTBsG/hOHGvQHuTe/UEIu11ngPTF1yZMK791myN8KWwxt/jtEqwr3RoIhPTNrQJVP6oz0U99JXY6ucZc89X/XkMdw4lJWF5vqkZDn2qnNj4+N4Qf8S0gKbNfaj9BNPF8/Q7cHbiVGBfn5UaMMaCyjk=;
  h=From:To:Cc:Subject:References:In-Reply-To:Date:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id;
In-Reply-To: <7v8wdnooza.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/134145>

Quoting Junio C Hamano <gitster@pobox.com>

> To avoid that, I think (1) the marker has to be more reliable than just
> "happens to have the same tree", and (2) the traversal done by Porcelains
> (your patches 3 thru 5) by default should be unaware of eqt.
>
> I don't know what a suitable marker should look like, though.  The marker
> must be easily identifiable by the lowest level rev-list machinery, so it
> needs to be a sign left somewhere in the commit object.  Perhaps making it
> require to have the same tree as all its parents _and_ a well-known marker
> string in the log message (and nothing else) would be a good start.

I think you can record a merge commit that has an unusual 
list of parents for this. For example, you can record the 
latest version twice, as the first and the second parents, 
and make the previous version the third parent. Because 
such a merge can't be created with git-merge command, you 
can reliably tell that it is an unusual 'marker' merge.

No matter what techinique is used to mark the special 
'marker', if it happens in real life for two or more people 
who worked independantly to arrive at the same conclusion, 
I don't think dismissing it as 'by chance' and discarding 
the contribution from the second branch is a good solution. 
If git is meant to work smoothly in projects where more than 
one person see and accept patches from the same origin, the 
condition is not met 'by chance'; the tool is by design 
supposed to handle it as a regular situation.

On the other hand, if you made the marker reliable, I think 
you don't have to disable this feature by default like you 
said in your (2).

As a side note, I have a bug to report. I tried this sequence 
of commands to make sure git-merge doesn't record the same 
parent twice (the last git-merge is made on the slave branch 
and tries to have slave, master and slave as its three 
parents).

 % git init
 % echo hello >world
 % git add . ; git commit -m first
 % echo again >world
 % git commit -a -m master
 % git checkout -b slave master^
 % echo again >world
 % git commit -a -m slave
 % git merge master slave

But I got the "usage: ..." error message from git-merge.

-- 
Nanako Shiraishi
http://ivory.ap.teacup.com/nanako3/
