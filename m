From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: Git Scaling: What factors most affect Git performance for a large repo?
Date: Sat, 21 Feb 2015 11:01:12 +0700
Message-ID: <CACsJy8B6pLnx84Xxb0_p2+YuWTgg_8h0yQt7K+AXiaEaC4jSeQ@mail.gmail.com>
References: <CAH8BJxEr_v+aitpZduXPC4oiRhMuySpc7Wb1aGcYe_p3mWjn+w@mail.gmail.com>
 <CACsJy8Dortn4fHwF8xSgJ=KoJ9o1qzmc_UyaVq003D2sxFZEuQ@mail.gmail.com> <1424392969.30029.15.camel@leckie>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Stephen Morton <stephen.c.morton@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: David Turner <dturner@twopensource.com>
X-From: git-owner@vger.kernel.org Sat Feb 21 05:01:48 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YP1GF-0005U5-Gh
	for gcvg-git-2@plane.gmane.org; Sat, 21 Feb 2015 05:01:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755461AbbBUEBn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 20 Feb 2015 23:01:43 -0500
Received: from mail-ig0-f173.google.com ([209.85.213.173]:42010 "EHLO
	mail-ig0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755033AbbBUEBm (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 Feb 2015 23:01:42 -0500
Received: by mail-ig0-f173.google.com with SMTP id a13so7665903igq.0
        for <git@vger.kernel.org>; Fri, 20 Feb 2015 20:01:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=n/NMOBInGioofSmrkrmNyil7S5CIkJC9tvGn23FkYwE=;
        b=mToeEqEz+N/dTC0gIpKSo5qeInQUInFqJbRiCFfWpImWiQqKZX3Wvyf2Tm2zR+TEIe
         zY1WQVBUuJaJh1H/AUcFw8fR+L4/NLiUnbHD9uujslEiYEenmQhg0eSG3VUFLahOqGIt
         ONwt+lVmXB4KoYTnlzMIh2hB1TO/Sl6NfOOhj5ikdbE2rVU2XLYgn8TZCqniTSs/68Zq
         H/5LifsFKHldZ6SCiCIh7yPEQpo6agYSISAXcln4j6J0W3hugT5zCxoMIP0Nb/9MSuvE
         TTmTYTojMiDXH/P+YHyAw5ppczZfDA59QZzxZ1+7QfI6/MNorDQzCxPmG31qQUpsnsyf
         XUhA==
X-Received: by 10.50.142.38 with SMTP id rt6mr706055igb.39.1424491302311; Fri,
 20 Feb 2015 20:01:42 -0800 (PST)
Received: by 10.107.131.155 with HTTP; Fri, 20 Feb 2015 20:01:12 -0800 (PST)
In-Reply-To: <1424392969.30029.15.camel@leckie>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/264203>

On Fri, Feb 20, 2015 at 7:42 AM, David Turner <dturner@twopensource.com> wrote:
> On Fri, 2015-02-20 at 06:38 +0700, Duy Nguyen wrote:
>> >    * 'git push'?
>>
>> This one is not affected by how deep your repo's history is, or how
>> wide your tree is, so should be quick..
>>
>> Ah the number of refs may affect both git-push and git-pull. I think
>> Stefan knows better than I in this area.
>
> I can tell you that this is a bit of a problem for us at Twitter.  We
> have over 100k refs, which adds ~20MiB of downstream traffic to every
> push.
>
> I added a hack to improve this locally inside Twitter: The client sends
> a bloom filter of shas that it believes that the server knows about; the
> server sends only the sha of master and any refs that are not in the
> bloom filter.  The client  uses its local version of the servers' refs
> as if they had just been sent.  This means that some packs will be
> suboptimal, due to false positives in the bloom filter leading some new
> refs to not be sent.  Also, if there were a repack between the pull and
> the push, some refs might have been deleted on the server; we repack
> rarely enough and pull frequently enough that this is hopefully not an
> issue.

I wonder how efficient rsync is for transferring these refs: the
client generates a "file" containing all refs, the server does the
same with their refs, then the client rsync their file to the server..
The changes between the server and the client files are usually small,
I'm hoping rsync can take advantage of that.
-- 
Duy
