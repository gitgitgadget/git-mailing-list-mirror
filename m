From: Peter Kjellerstedt <peter.kjellerstedt@axis.com>
Subject: RE: [PATCH] string-list.h: Add STRING_LIST_INIT macro and make use
 of  it.
Date: Tue, 29 Jun 2010 10:15:38 +0200
Message-ID: <A612847CFE53224C91B23E3A5B48BAC74483CEF76D@xmail3.se.axis.com>
References: <c4c9797a4cbea89f1f0fb0501e6a03912b598b17.1277595284.git.tfransosi@gmail.com>
 <de7ad1688930aa47515736885b7d8438118e7aa1.1277595923.git.tfransosi@gmail.com>
 <7vbpawifwa.fsf@alter.siamese.dyndns.org>
 <AANLkTim14fh1RRSoYFK5uIqi8OrkB2zHahInDpO80gws@mail.gmail.com>
 <7v4ogmcs1u.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Cc: Thiago Farina <tfransosi@gmail.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>,
	"jrnieder@gmail.com" <jrnieder@gmail.com>,
	"srabbelier@gmail.com" <srabbelier@gmail.com>
To: Junio C Hamano <gitster@pobox.com>,
	Alex Riesen <raa.lkml@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jun 29 10:16:16 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OTVzJ-0001NO-8H
	for gcvg-git-2@lo.gmane.org; Tue, 29 Jun 2010 10:16:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753924Ab0F2IQF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 29 Jun 2010 04:16:05 -0400
Received: from miranda.se.axis.com ([193.13.178.8]:60875 "EHLO
	miranda.se.axis.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753043Ab0F2IQE convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 29 Jun 2010 04:16:04 -0400
Received: from xmail3.se.axis.com (xmail3.se.axis.com [10.0.5.75])
	by miranda.se.axis.com (8.13.4/8.13.4/Debian-3sarge3) with ESMTP id o5T8FkW4019902;
	Tue, 29 Jun 2010 10:15:46 +0200
Received: from xmail3.se.axis.com ([10.0.5.75]) by xmail3.se.axis.com
 ([10.0.5.75]) with mapi; Tue, 29 Jun 2010 10:15:46 +0200
Thread-Topic: [PATCH] string-list.h: Add STRING_LIST_INIT macro and make use
 of  it.
Thread-Index: AcsXThZoQLv42e7+Ssms7YqcNV1XjwAFAmxw
In-Reply-To: <7v4ogmcs1u.fsf@alter.siamese.dyndns.org>
Accept-Language: en-US, sv-SE
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
acceptlanguage: en-US, sv-SE
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/149891>

> -----Original Message-----
> From: git-owner@vger.kernel.org [mailto:git-owner@vger.kernel.org] On
> Behalf Of Junio C Hamano
> Sent: den 29 juni 2010 07:43
> To: Alex Riesen
> Cc: Thiago Farina; git@vger.kernel.org; jrnieder@gmail.com;
> srabbelier@gmail.com
> Subject: Re: [PATCH] string-list.h: Add STRING_LIST_INIT macro and make
> use of it.
> 
> Alex Riesen <raa.lkml@gmail.com> writes:
> 
> >> But I wonder if this is worth it (not this "more complete", but 
> >> your patch). We convert 16 or so instances of initialization for
> >> "no strdup" list, but there are about the same number of "strdup" 
> >> instances still spelled out:
> >>
> >>    $ git grep -e 'struct string_list [^ ]* = {.*'
> >>    $ git grep -e 'struct string_list [^ ]* = {.*1'
> >>
> >> Wouldn't it be more sensible to use this instead?
> >>
> >>    #define STRING_LIST_INIT(pleasedup) { NULL, 0, 0, (pleasedup) }
> >
> > This begs for using strdup(string-to-dup) in the macro argument,
> > which will not compile with ancient compilers which don't allow 
> > code in an initializer.
> 
> Err, one of us must be confused.
> 
> I was suggesting to rewrite things like these, found in
> builtin/remote.c (add and rm):
> 
> 	struct string_list track = { NULL, 0, 0, 0 };
> 	struct string_list branches = { NULL, 0, 0, 1 };
> 
> like so:
> 
> 	#define STRING_LIST_INIT(pleasedup) { NULL, 0, 0, (pleasedup) }
> 	struct string_list track = STRING_LIST_INIT(0);
>         struct string_list branches = STRING_LIST_INIT(1);
> 
> I don't see strdup in macro argument anywhere.
> 
> The original patch in this thread proposed to do this instead:
> 
> 	#define STRING_LIST_INIT { NULL, 0, 0, 0 }
> 	struct string_list track = STRING_LIST_INIT;
>         struct string_list branches = { NULL, 0, 0, 1 };
> 
> converting about half of initializers to the macro, and leaving the
> other half spelled out.

How about using two macros instead:

#define STRING_LIST_INIT { NULL, 0, 0, 0 }
#define STRING_LIST_INIT_DUP { NULL, 0, 0, 1 }

That way there is less confusion to what the 0/1 argument
to STRING_LIST_INIT() means. (I guess STRING_LIST_INIT could 
be STRING_LIST_INIT_NODUP instead if one wants more clarity.)

//Peter
