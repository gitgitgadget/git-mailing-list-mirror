From: James Cloos <cloos@jhcloos.com>
Subject: Re: git-fetch vs ipv6 routing issues
Date: Tue, 03 Jun 2008 15:53:52 -0400
Message-ID: <m3wsl6guqg.fsf@lugabout.jhcloos.org>
References: <m38wxq1hou.fsf@eagle.jhcloos.com>
	<alpine.LRH.1.10.0806010924340.27605@yvahk3.pbagnpgbe.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Daniel Stenberg <daniel@haxx.se>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jun 03 21:56:03 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K3cbj-0005iR-Gk
	for gcvg-git-2@gmane.org; Tue, 03 Jun 2008 21:55:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754873AbYFCTyf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 Jun 2008 15:54:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754870AbYFCTye
	(ORCPT <rfc822;git-outgoing>); Tue, 3 Jun 2008 15:54:34 -0400
Received: from eagle.jhcloos.com ([207.210.242.212]:1866 "EHLO
	eagle.jhcloos.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754681AbYFCTyd (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Jun 2008 15:54:33 -0400
Received: by eagle.jhcloos.com (Postfix, from userid 10)
	id 0A6C44012D; Tue,  3 Jun 2008 19:54:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jhcloos.com;
	s=eagle; t=1212522872; bh=xTv80Zsk7QH9/OTdG/ZL1UWKGBG9b/U2UE8M1GKt1
	yg=; h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=QVkMz+jkf5tQN162N1kzE/icEpimCURpsIs8y
	Y1qcD0wDwCS5uBmLuqr+ds8cpDjdoYyT2zBqR8aI1X7AJnOicJ/IKV422M2ZnOf+5D5
	K7shwWJkkXONH6Y3vfyN+sP8z9SVcZvvnBHwL+48/Nk0NN79R6s5AR6m1uiwUngPFMA
	=
Received: by lugabout.jhcloos.org (Postfix, from userid 500)
	id 7E7122103CF; Tue,  3 Jun 2008 19:54:16 +0000 (UTC)
In-Reply-To: <alpine.LRH.1.10.0806010924340.27605@yvahk3.pbagnpgbe.fr> (Daniel
	Stenberg's message of "Sun, 1 Jun 2008 09:25:30 +0200 (CEST)")
User-Agent: Gnus/5.110011 (No Gnus v0.11) Emacs/23.0.60 (gnu/linux)
Face: iVBORw0KGgoAAAANSUhEUgAAABAAAAAQCAYAAAAf8/9hAAAABHNCSVQICAgIfAhkiAAAAI1J
 REFUOE+lU9ESgCAIg64P1y+ngUdxhl5H8wFbbM0OmUiEhKkCYaZThXCo6KE5sCbA1DDX3genvO4d
 eBQgEMaM5qy6uWk4SfBYfdu9jvBN9nSVDOKRtwb+I3epboOsOX5pZbJNsBJFvmQQ05YMfieIBnYX
 FK2N6dOawd97r/e8RjkTLzmMsiVgrAoEugtviCM3v2WzjgAAAABJRU5ErkJggg==
Copyright: Copyright 2007 James Cloos
OpenPGP: ED7DAEA6; url=http://jhcloos.com/public_key/0xED7DAEA6.asc
OpenPGP-Fingerprint: E9E9 F828 61A4 6EA9 0F2B  63E7 997A 9F17 ED7D AEA6
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/83694>

>>>>> "Daniel" == Daniel Stenberg <daniel@haxx.se> writes:

>> I just noticed that, given a remote URL with a hostname which has
>> both A and AAAA RRs in the DNS, git-fetch will retry a git-protocol
>> fetch using the v4 address if the v6 address is unreachable, but
>> will not do so when the remote is an http URL.

Daniel> Isn't this simply because libcurl (used for http) has no retry
Daniel> functionality on this scenario while git itself has that for the
Daniel> git protocol?

Yes, that is true.

But git could be smarter about it.  libcurl has CURLOPT_IPRESOLVE which
can be set to any of CURL_IPRESOLVE_WHATEVER, CURL_IPRESOLVE_V4 or
CURL_IPRESOLVE_V6.  Git could at least allow setting that via a config
option and/or an env var, just like it does for libcurl options like
CURLOPT_LOW_SPEED_LIMIT.

Even better would be to set CURLOPT_CONNECT_ONLY and then try with
CURL_IPRESOLVE_WHATEVER, CURL_IPRESOLVE_V6 and CURL_IPRESOLVE_V4 in turn
until it gets a connection, and then use CURLINFO_LASTSOCKET and the
full URL to do the GET.

-JimC
-- 
James Cloos <cloos@jhcloos.com>         OpenPGP: 1024D/ED7DAEA6
