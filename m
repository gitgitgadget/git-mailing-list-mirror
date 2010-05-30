From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [RFC/PATCH 2/4] revert: refactor code into a do_pick_commit()
 function
Date: Sun, 30 May 2010 15:07:08 -0500
Message-ID: <20100530200708.GA32728@progeny.tock>
References: <20100529043738.569.85482.chriscool@tuxfamily.org>
 <20100529044044.569.69037.chriscool@tuxfamily.org>
 <AANLkTik6SBEkOICHdMYprzGitfS2hezDXKQ8Q5R8cAYs@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Christian Couder <chriscool@tuxfamily.org>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Sun May 30 22:06:34 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OIomI-0003HY-Fr
	for gcvg-git-2@lo.gmane.org; Sun, 30 May 2010 22:06:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753822Ab0E3UGa convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 30 May 2010 16:06:30 -0400
Received: from mail-yw0-f179.google.com ([209.85.211.179]:35933 "EHLO
	mail-yw0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753510Ab0E3UG3 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 30 May 2010 16:06:29 -0400
Received: by ywh9 with SMTP id 9so2023533ywh.17
        for <git@vger.kernel.org>; Sun, 30 May 2010 13:06:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=4HPNOeAnvSFCVrwJg0seefAI23GjCTiKYuAevUrgg3w=;
        b=wSPnjjYPKJG+6mHqRPvQlVsLQrzogk0GUHcRHc+jezeTH4+ov1mZQfHJOF9iUfUhBG
         0Q3Mw21Av9FUMb1dCa3Tjn4/V9JQqz/+Eu254I8vRz5STNTPLPEJl8JVxFO1dRe41pmH
         fdhUDpWfSHm4nDkYy3YU4lgnI+aoaZCsYwLk0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=w/ncC8ZvAMK5w7k1c3yhyArYadfzOo+GezJGbLvih7BtFQ0xIJSZamgX4o30blrICT
         +ckbtqGJChcz6KdNLTzhbXzdixRzSf/5TqxSj4+YKfYA4sPHXbDyHpiyfr83RdTJSJq+
         /GJbQAnntKmD4uZKIzlvPLFqYH+sG/qWncAJg=
Received: by 10.231.178.162 with SMTP id bm34mr4439922ibb.86.1275249988602;
        Sun, 30 May 2010 13:06:28 -0700 (PDT)
Received: from progeny.tock (c-98-212-3-231.hsd1.il.comcast.net [98.212.3.231])
        by mx.google.com with ESMTPS id d9sm22564084ibl.22.2010.05.30.13.06.27
        (version=SSLv3 cipher=RC4-MD5);
        Sun, 30 May 2010 13:06:27 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <AANLkTik6SBEkOICHdMYprzGitfS2hezDXKQ8Q5R8cAYs@mail.gmail.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/148014>

Ramkumar Ramachandra wrote:
> Christian Couder wrote:

>> -static int revert_or_cherry_pick(int argc, const char **argv)
>> +static int do_pick_commit()
>> =A0{
>> =A0 =A0 =A0 =A0unsigned char head[20];
>> =A0 =A0 =A0 =A0struct commit *base, *next, *parent;
>
> Is there a better way to do this instead of allocating memory for eac=
h
> commit? When you cherry pick a lot of commits, it might make sense to
> use a shared memory pool.

In fact they do belong to a pool, as far as I can tell.

  lookup_commit_reference ->
   lookup_commit_reference_gently ->
    parse_object ->
     parse_object_buffer ->
      lookup_commit ->
       lookup_object (or create_object, alloc_commit_node)

alloc_commit_node is defined in alloc.c to draw from a growing array
of fixed-size, never-freed commit objects.

Hope that helps.
Jonathan
