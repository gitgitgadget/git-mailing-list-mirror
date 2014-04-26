From: David Kastrup <dak@gnu.org>
Subject: Re: [PATCH 1/2] blame: large-scale performance rewrite
Date: Sat, 26 Apr 2014 23:39:19 +0200
Message-ID: <87vbtv7ou0.fsf@fencepost.gnu.org>
References: <1398470210-28746-1-git-send-email-dak@gnu.org>
	<CAJo=hJukmej1rJXuVoECwd7AxmSue8Wmv4rBmCHEYcWBWNarSw@mail.gmail.com>
	<87wqec8rb5.fsf@fencepost.gnu.org>
	<CAJo=hJs=ap=Ct_PzOsO=vHmDVMvUF+nvbB7b67bgnmug+Yrohg@mail.gmail.com>
	<87d2g481nb.fsf@fencepost.gnu.org> <874n1g80dd.fsf@fencepost.gnu.org>
	<CAJo=hJs-Nn=o=aGS_3bO9mnxb+urst6JTZf29_qAejBipz_ZHg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git <git@vger.kernel.org>
To: Shawn Pearce <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Sun Apr 27 14:21:13 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WeO51-0003A9-3h
	for gcvg-git-2@plane.gmane.org; Sun, 27 Apr 2014 14:21:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752145AbaD0MUf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 27 Apr 2014 08:20:35 -0400
Received: from fencepost.gnu.org ([208.118.235.10]:39749 "EHLO
	fencepost.gnu.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751694AbaD0MUe (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 27 Apr 2014 08:20:34 -0400
Received: from localhost ([127.0.0.1]:38787 helo=lola)
	by fencepost.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dak@gnu.org>)
	id 1WeO4P-0002jU-96; Sun, 27 Apr 2014 08:20:33 -0400
Received: by lola (Postfix, from userid 1000)
	id 67FF0E060B; Sat, 26 Apr 2014 23:39:19 +0200 (CEST)
In-Reply-To: <CAJo=hJs-Nn=o=aGS_3bO9mnxb+urst6JTZf29_qAejBipz_ZHg@mail.gmail.com>
	(Shawn Pearce's message of "Sat, 26 Apr 2014 10:56:22 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.4.50 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/247198>

Shawn Pearce <spearce@spearce.org> writes:

> On Sat, Apr 26, 2014 at 10:30 AM, David Kastrup <dak@gnu.org> wrote:
>> David Kastrup <dak@gnu.org> writes:
>>
>> Here's some example:
>>
>> dak@lola:/usr/local/tmp/wortliste$ time git blame -n -s wortliste >/tmp/wl1
>>
>> real    15m47.118s
>> user    14m39.928s
>> sys     1m1.872s
>
> Hah, this is quite the torture test. git before your patch is taking
> 22m11s on my laptop to compute this. (This was with default options, I
> noticed you passed -s to suppress the author formatting.)
>
>> dak@lola:/usr/local/tmp/wortliste$ time ../git/git blame -n -s wortliste >/tmp/wl2
>>
>> real    3m40.947s
>> user    2m40.296s
>> sys     0m59.440s
>
> Meanwhile JGit computed in 4m30s on the same hardware. So I guess we
> are "fine".

At least the stuff I fixed with regard to performance would seem to be
done right in JGit to start with.

> Its still not as fast as I want it to be. :-)

Most of the diff data/CRC is computed over and over because of the
blackbox use of xdiff.  And then the delta-chain storage is packing
stuff based on CRCs as well (not sure whether it keeps them around for
unpacking).  So there is a lot that could likely be improved while
keeping the same basic algorithms, by cracking open the black boxes of
the xdiff engine and the delta-chain coding.

-- 
David Kastrup
