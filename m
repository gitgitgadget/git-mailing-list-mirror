From: "Reece Dunn" <msclrhd@googlemail.com>
Subject: Re: git-bisect: weird usage of read(1)
Date: Mon, 11 Aug 2008 16:59:32 +0100
Message-ID: <3f4fd2640808110859r148550d2h833dae05b9e6544e@mail.gmail.com>
References: <38b2ab8a0808110657y24ac9526wca4acea3bddaec00@mail.gmail.com>
	 <alpine.DEB.1.00.0808111615260.24820@pacific.mpi-cbg.de.mpi-cbg.de>
	 <38b2ab8a0808110718x2f63608ga3d2d77e317ce4eb@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Johannes Schindelin" <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: "Francis Moreau" <francis.moro@gmail.com>
X-From: git-owner@vger.kernel.org Mon Aug 11 18:00:50 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KSZoy-00023I-MM
	for gcvg-git-2@gmane.org; Mon, 11 Aug 2008 18:00:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751667AbYHKP7e (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 11 Aug 2008 11:59:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751348AbYHKP7d
	(ORCPT <rfc822;git-outgoing>); Mon, 11 Aug 2008 11:59:33 -0400
Received: from rv-out-0506.google.com ([209.85.198.225]:14553 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751492AbYHKP7d (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Aug 2008 11:59:33 -0400
Received: by rv-out-0506.google.com with SMTP id k40so2315292rvb.1
        for <git@vger.kernel.org>; Mon, 11 Aug 2008 08:59:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=FVoTa/RGZUMvU9Br5y2uh9oZMwXbYjqqFQt5LtiyQis=;
        b=OTCIMj9MYo7zfoMDswry/JIKXCS5EsYSXYf5W9aZnHcVZH8+76S/BZvdjeCvzr9/g5
         p+5T4f1XuTDjARaAwDyzLFM2J0NHJy3vsluWhSusdwx4QdBu4Q1JMwHwjp8JGYp50TDj
         p/BsT+9tiRbqTK9G3/u5C577a7oIFj8qn7e9Q=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=WM/8q6G4bHZ5hVYhk0f8YYTsZ6FS7ZkCFecET3tdkkaEsq18kPtlkHrpsffeRHcCGC
         ffa6o5UeEODdWLp7qolL04HNi+JFM4Kmtpu6wq0g9Mb7YPWKWfKt9e4v36NUlSLsvnhO
         mswaMTmZu8GA461CewqThwMnt6XpouTTlJXao=
Received: by 10.141.210.21 with SMTP id m21mr3629797rvq.23.1218470372546;
        Mon, 11 Aug 2008 08:59:32 -0700 (PDT)
Received: by 10.141.87.10 with HTTP; Mon, 11 Aug 2008 08:59:32 -0700 (PDT)
In-Reply-To: <38b2ab8a0808110718x2f63608ga3d2d77e317ce4eb@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/91954>

2008/8/11 Francis Moreau <francis.moro@gmail.com>:
> Hello
>
> On Mon, Aug 11, 2008 at 4:15 PM, Johannes Schindelin
> <Johannes.Schindelin@gmx.de> wrote:
>> Hi,
>>
>> On Mon, 11 Aug 2008, Francis Moreau wrote:
>>
>>> I found this in git bisect:
>>>
>>>               printf >&2 'Are you sure [Y/n]? '
>>>               case "$(read yesno)" in [Nn]*) exit 1 ;; esac
>>>
>>> which looks very weird since read(1) returns a status and not the
>>> string reads from std input.
>>>
>
> sorry I should have said that there's a status but no output...
>
>>> Am I missing something ?
>>
>> Yes.  "$()" does not return the status, but the output.
>>
>
> But what's the output in that case ?

Using cygwin+bash, I get:

$ echo $(read yesno)
n

$ echo $(read yesno; echo $yesno)
n
n
$ $(read yesno) && echo yes || echo no
n
yes
$ $(read yesno) && echo yes || echo no
y
yes
$ case "$(read yesno)" in [Nn]*) echo "no" ;; esac
n
$ case "$(read yesno)" in [Nn]*) echo "no" ;; esac
y
$ case "$(read yesno; echo $yesno)" in [Nn]*) echo "no" ;; esac
n
no
$ case "$(read yesno; echo $yesno)" in [Nn]*) echo "no" ;; esac
y

So

>>>               case "$(read yesno)" in [Nn]*) exit 1 ;; esac

does not work as expected. Replacing this with

               case "$(read yesno; echo $yesno)" in [Nn]*) exit 1 ;; esac

would work as intended, as Mikael has pointed out.

- Reece
