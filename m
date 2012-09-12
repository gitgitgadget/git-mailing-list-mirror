From: =?ISO-8859-1?Q?Torsten_B=F6gershausen?= <tboegi@web.de>
Subject: Re: [PATCH v2] fetch: align new ref summary printout in UTF-8 locales
Date: Wed, 12 Sep 2012 22:12:02 +0200
Message-ID: <5050EC92.6000103@web.de>
References: <1346670609-19986-1-git-send-email-pclouds@gmail.com> <1346755175-31468-1-git-send-email-pclouds@gmail.com> <CACsJy8APtTU-7ZfTdcjg0nKoBSboNpP+7Va=akXcvn95Sd166A@mail.gmail.com> <7vpq5rce6y.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Nguyen Thai Ngoc Duy <pclouds@gmail.com>, git@vger.kernel.org,
	=?ISO-8859-1?Q?Torsten_B=F6gershausen?= <tboegi@web.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Sep 12 22:12:18 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TBtII-00018v-9a
	for gcvg-git-2@plane.gmane.org; Wed, 12 Sep 2012 22:12:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752530Ab2ILUMK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 12 Sep 2012 16:12:10 -0400
Received: from mout.web.de ([212.227.15.4]:58123 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752023Ab2ILUMI (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 12 Sep 2012 16:12:08 -0400
Received: from birne.lan ([195.67.191.22]) by smtp.web.de (mrweb002) with
 ESMTPA (Nemesis) id 0LbZpT-1Twjdp1e8Z-00kqJv; Wed, 12 Sep 2012 22:12:05 +0200
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.6; rv:15.0) Gecko/20120907 Thunderbird/15.0.1
In-Reply-To: <7vpq5rce6y.fsf@alter.siamese.dyndns.org>
X-Provags-ID: V02:K0:OAnZbEwWcLAeDDdjl05kLGpbumNImBAAuThqUerrPUq
 nTrfBUP2/FP6fV+W/M5Hy8nJYR7umPe1PgCu7zqES+DfztlFBn
 DcrYPnf085ARzQ9bHOHUTTZybgyOUUHYnTvMH3tItSR+7B22Wc
 mTY2W/W4W6Co5AMJX421pxImPNae0MthNPoCs6WjVGreUeQyKa
 2TRCPKYe9YwdGBEMEO+OA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/205332>

On 12.09.12 20:02, Junio C Hamano wrote:
> Nguyen Thai Ngoc Duy <pclouds@gmail.com> writes:
> 
>> Ping.. what happens to this patch? Do you want to support other
>> encodings as well via iconv()? I can't test that though.
> 
> I thought I refuted a potential blocker, which was an implied
> objection from Torsten, in $gmane/204912 already.  As long as we
> make it clear that your patch helps only "ASCII/UTF-8 only" audience
> but we still "try to be nicer to 'others'" by doing two things I
> said in the message, I think we should proceed without iconv() to
> keep things simple.

Please unblock and proceed (as I can't test other encodings either)

And even special thanks for the excellent lines from Junio,
which explained the update philosophy in git so well, 
that I take the freedom to re-post them here:

>> I try to re-phrase my question:
>>
>> Do installations still exist which use e.g. BIG5 or any other
>> multi byte encoding which is not UTF-8?
>
>Yes.
>
>> Do we want to support other encodings than ASCII or UTF-8?
>> (Because then the screen width needs to be calculate different, I think)
>
>That depends on who "we" are and what timeframe you have in mind.
>
>Do our developers care about these encodings so much that we would
>reject "ASCCI/UTF-8 only" patch and wait until we enhance it to do
>the right thing for other encodings that we do not use ourselves?
>No.  That does not make any sense, especially when we know we will
>not have a good test coverage on the additional parts that we will
>not be using ourselves.
>
>"This change only helps people with ASCII or UTF-8 and does not help
>others" alone is never a valid reason to reject a change, but we
>still try to be nicer to "others" that may come after we leave this
>topic behind by doing a few things:
>
> - If the change will make things worse than it currently is for
>   "others", we would try to minimize the regression for them.
>
> - If the change will make the code harder to update later to
>   enhance with additional change to support "others", we would try
>   to anticipate what kind of changes are needed on top, and
>   structure the code in such a way that future changes can be made
>   cleanly.
>
>For the first point, for multi-byte encodings (e.g. ISO-2022), the
>display columns and byte length do not match and in general byte
>length is longer than the display columns in the current code.  With
>the current code that measures the required columns across elements
>by taking the maximum of byte length, they will see wrong number of
>filler, so they are already getting a wrong alignment.  With the
>"UTF-8 only" change, the required columns and the filler will be
>calculated by assuming that the string is in UTF-8, which may make
>the computation off in a different way, and if we underestimate the
>display columns for a string, they may see the strings truncated,
>which is bad.
>
>So as long as gettext_width() punts and returns strlen() for a
>malformed UTF-8, it would be OK [*1*].
>
>For the second point, I think the API "here is a string, give me the
>number of display columns it will occupy, as I am interested in
>aligning them" is a good abstraction that can be later enhanced to
>other encodings fairly easily, so I do not see a problem in the
>patch that goes in that direction.
>
>
>
>[Footnote]
>
>*1* If the patch used utf_strwidth() (which I didn't bother to go
>back and check, though), it should be OK.  The underlying
>utf8_width() will reject a malformed UTF-8 sequence and the code
>falls back to strlen().

 
