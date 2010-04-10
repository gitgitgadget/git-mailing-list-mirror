From: Julian Phillips <julian@quantumfyre.co.uk>
Subject: Re: git status --porcelain is a mess that needs fixing
Date: Sat, 10 Apr 2010 14:35:25 +0100
Message-ID: <9c7e1f33b7ec0dab68a92aa8f067989e@212.159.54.234>
References: <20100409184608.C7C61475FEF@snark.thyrsus.com> <20100410040959.GA11977@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: Eric Raymond <esr@snark.thyrsus.com>,
	Junio C Hamano <gitster@pobox.com>, <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sat Apr 10 15:35:35 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O0aqV-0003zd-EG
	for gcvg-git-2@lo.gmane.org; Sat, 10 Apr 2010 15:35:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751403Ab0DJNfa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 10 Apr 2010 09:35:30 -0400
Received: from positron.quantumfyre.co.uk ([213.165.84.138]:44801 "EHLO
	positron.quantumfyre.co.uk" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751033Ab0DJNf3 (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 10 Apr 2010 09:35:29 -0400
Received: from reaper.quantumfyre.co.uk (reaper.quantumfyre.co.uk [212.159.54.234])
	by positron.quantumfyre.co.uk (Postfix) with ESMTP id C7FB9819C4B6;
	Sat, 10 Apr 2010 14:35:21 +0100 (BST)
Received: from localhost (localhost [127.0.0.1])
	by reaper.quantumfyre.co.uk (Postfix) with ESMTP id 3A3A620C8F3;
	Sat, 10 Apr 2010 14:35:27 +0100 (BST)
X-Virus-Scanned: amavisd-new at reaper
Received: from reaper.quantumfyre.co.uk ([127.0.0.1])
	by localhost (reaper.quantumfyre.co.uk [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id M+L0+54dMet7; Sat, 10 Apr 2010 14:35:26 +0100 (BST)
Received: from webmail.quantumfyre.co.uk (reaper.quantumfyre.co.uk [192.168.0.2])
	by reaper.quantumfyre.co.uk (Postfix) with ESMTP id B0BF010F788;
	Sat, 10 Apr 2010 14:35:25 +0100 (BST)
In-Reply-To: <20100410040959.GA11977@coredump.intra.peff.net>
X-Sender: julian@quantumfyre.co.uk
User-Agent: RoundCube Webmail/0.1-rc1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/144546>

On Sat, 10 Apr 2010 00:09:59 -0400, Jeff King <peff@peff.net> wrote:
> Your parser is already broken if you are calling split, as the filenames
> may contain spaces (and will be quoted in that case, and you need to
> unmangle). You should use "-z".
> 
> You will probably then realize that the "-z" format looks like:
> 
>   XY file1\0file2\0
> 
> which still sucks. It would be more friendly as:
> 
>   XY\0file1\0file2\0
> 
> So you could split on "\0". But even with that, you can't just blindly
> split, as the column and record separators are the same, and you might
> have one or two filenames.

Not true.  If the second form was used, then you _can_ split on \0.  It
will tokenise the data for you, and then you consume ether two or three
tokens depending on the status flags.  So it would make the parsing
simpler.  But to make it even easier, how about adding a -Z that makes the
output format "XY\0file1\0[file2]\0" (i.e. always three tokens per record,
with the third token being empty if there is no second filename)?  Though
if future expandability was wanted you could end each record with \0\0 and
then parsing would be a two stages of split on \0\0 for records and then
split on \0 for entries?  The is already precedence for the -z option to
change the output format, so a second similar switch should be ok?  Then
the updated documentation could recommend --porcelain -Z for new users
without affecting old ones.

-- 
Julian
