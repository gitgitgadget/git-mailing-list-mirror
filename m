From: Fredrik Kuivinen <frekui@gmail.com>
Subject: Re: [PATCH] Make xmalloc and xrealloc thread-safe
Date: Wed, 31 Mar 2010 08:57:55 +0200
Message-ID: <s2t4c8ef71003302357x5e9defa1l4dbde6391d533ca5@mail.gmail.com>
References: <20100323161713.3183.57927.stgit@fredrik-laptop>
	 <alpine.LFD.2.00.1003231945480.31128@xanadu.home>
	 <4c8ef71003240823o7cd733bn5f19699305c94cba@mail.gmail.com>
	 <alpine.LFD.2.00.1003241133430.694@xanadu.home>
	 <ec874dac1003241122s3d592f26n1b23d23144939218@mail.gmail.com>
	 <alpine.LFD.2.00.1003241435300.694@xanadu.home>
	 <ec874dac1003241257r3cad86c9q1af84d3732e23ca8@mail.gmail.com>
	 <alpine.LFD.2.00.1003241613020.694@xanadu.home>
	 <4c8ef71003270626y45685e69j28ccb8a8738b9083@mail.gmail.com>
	 <alpine.LFD.2.00.1003271035360.694@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Shawn Pearce <spearce@spearce.org>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Johannes Sixt <j6t@kdbg.org>
To: Nicolas Pitre <nico@fluxnic.net>
X-From: git-owner@vger.kernel.org Wed Mar 31 08:58:07 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NwrsM-0007dd-L6
	for gcvg-git-2@lo.gmane.org; Wed, 31 Mar 2010 08:58:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751119Ab0CaG57 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 31 Mar 2010 02:57:59 -0400
Received: from mail-fx0-f223.google.com ([209.85.220.223]:38881 "EHLO
	mail-fx0-f223.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755072Ab0CaG56 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 31 Mar 2010 02:57:58 -0400
Received: by fxm23 with SMTP id 23so897053fxm.21
        for <git@vger.kernel.org>; Tue, 30 Mar 2010 23:57:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:received:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=A42xDASnjceJtlDolTJCzO5DWSwdNN0M9LNf0d0Ugjk=;
        b=jI9KVLclonbD4P8Iw5CxXeeFtVuDVtHSqwoiOd8OIHXPAa5XUo5Qwf4mGAB5jTh4Gd
         JpRz0CmArQ1CmH1IwL3Z2WFoVxySLt+u0QfVI8Og/6vUYlOMf0vGQhn0wlq6x9eSVPkb
         BsP5uKsZVBW46zMsYC1inpZOSuIyGArhhuf6k=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=JXgdkK22t+FB5WcT8jOdg50RdJHFp4PxOx27oN84lmF1EPfbPgkTS6tV8YkYwlJZCm
         vHTE9OZCRI+pfynYeXz0iZNZ3ONaZ3f4JqNUNAqlAoHf3+zB8ysH2Pgl7Zm3CvyMCMGL
         23kysA5YjtN26K6G3veLOmPqIFT7Z33iX0dzI=
Received: by 10.239.140.138 with HTTP; Tue, 30 Mar 2010 23:57:55 -0700 (PDT)
In-Reply-To: <alpine.LFD.2.00.1003271035360.694@xanadu.home>
Received: by 10.239.134.148 with SMTP id 20mr646226hbz.42.1270018675876; Tue, 
	30 Mar 2010 23:57:55 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/143649>

On Sat, Mar 27, 2010 at 19:59, Nicolas Pitre <nico@fluxnic.net> wrote:
> On Sat, 27 Mar 2010, Fredrik Kuivinen wrote:
>
>> On Wed, Mar 24, 2010 at 21:22, Nicolas Pitre <nico@fluxnic.net> wrot=
e:
>> > +static void try_to_free_from_threads(size_t size)
>> > +{
>> > + =A0 =A0 =A0 read_lock();
>> > + =A0 =A0 =A0 release_pack_memory(size, -1);
>> > + =A0 =A0 =A0 read_unlock();
>> > +}
>> > +
>>
>> Will this really work in all cases? In the find_deltas -> try_delta =
->
>> read_sha1_file -> ... -> xmalloc call path, the mutex is already
>> locked when we get to xmalloc.
>
> You're right. =A0Damn.

A simple fix is to make it a recursive mutex instead. This will work
with a minimal change in win32 as well as the CRITICAL_SECTION type is
recursive.

I guess the downside is that the locking potentially gets slightly slow=
er.


- Fredrik
