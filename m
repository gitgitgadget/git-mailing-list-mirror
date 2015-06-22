From: Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH v6 18/19] fsck: git receive-pack: support excluding
 objects from fsck'ing
Date: Mon, 22 Jun 2015 10:49:12 +0200
Organization: gmx
Message-ID: <5fd3e400f4466965f8949ecf2440fc41@www.dscho.org>
References: <cover.1434657920.git.johannes.schindelin@gmx.de>
 <cover.1434720655.git.johannes.schindelin@gmx.de>
 <e843f9f1defca543d3f2eb3143cf9fee8c72f695.1434720655.git.johannes.schindelin@gmx.de>
 <CAPc5daV2P_vR-wjuU-0W81F9_phawHaQM1HHpOqNTsNDyQ5NHQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>,
	Michael Haggerty <mhagger@alum.mit.edu>,
	Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jun 22 10:49:37 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z6xQ8-0006Fv-Nx
	for gcvg-git-2@plane.gmane.org; Mon, 22 Jun 2015 10:49:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932252AbbFVIta (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 22 Jun 2015 04:49:30 -0400
Received: from mout.gmx.net ([212.227.15.18]:58553 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751437AbbFVIta (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 22 Jun 2015 04:49:30 -0400
Received: from www.dscho.org ([87.106.4.80]) by mail.gmx.com (mrgmx001) with
 ESMTPSA (Nemesis) id 0Ma1tv-1ZOkkO0Pj5-00LlWS; Mon, 22 Jun 2015 10:49:15
 +0200
In-Reply-To: <CAPc5daV2P_vR-wjuU-0W81F9_phawHaQM1HHpOqNTsNDyQ5NHQ@mail.gmail.com>
X-Sender: johannes.schindelin@gmx.de
User-Agent: Roundcube Webmail/1.1.0
X-Provags-ID: V03:K0:yb9eb4p/qWA9zI2Xq8gYkAfeDD07CT9stkMnj8Rct/vutAdOO8R
 GOTwYK6HZI3rCSfXKFKsde8CA5yZAm+2xuqF+ljzf554+RASq+HwFXFd0Z0NenpXer/8Zpp
 CvztUUQHGuA9Wuh7GE3tm9YvQ1//uqqfz1c5Mx3jAnVpacW4mRDh5b0XECsq7xhkT8hceaT
 g5raATx3+hAdK0t5SHHjw==
X-UI-Out-Filterresults: notjunk:1;
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/272320>

Hi Junio,

On 2015-06-22 06:21, Junio C Hamano wrote:
> On Fri, Jun 19, 2015 at 6:35 AM, Johannes Schindelin
> <johannes.schindelin@gmx.de> wrote:
>>
>> @@ -227,6 +277,10 @@ static int report(struct fsck_options *options, struct object *object,
>>         if (msg_type == FSCK_IGNORE)
>>                 return 0;
>>
>> +       if (options->skiplist && object &&
>> +                       sha1_array_lookup(options->skiplist, object->sha1) >= 0)
>> +               return 0;
>> +
>>         if (msg_type == FSCK_FATAL)
>>                 msg_type = FSCK_ERROR;
>>         else if (msg_type == FSCK_INFO)
> 
> I just double checked this patch because I wanted to make sure this
> was applied in the
> report() function (i.e. behave as if FSCK_IGNORE was specified for
> specific objects on
> the skip list), and I am happy to see that it indeed is the case.
> 
> That was because I briefly feared that skip could be done before going
> through the usual
> verification chain, which would have been very wrong (e.g. we may want
> not to hear about
> missing tagger in v2.6.11-tree tag, but nevertheless we would want to
> check all the tree
> contents pointed at by that tag, as that tree may not be reachable by
> any other way).

To be honest, an earlier iteration actually did have that test much earlier in the call chain, but I had changed it to the current location in v5.

My rationale was slightly different from yours: I wanted to affect the performance as little as possible. So looking up each and every object in the skip list (which I expect to be relatively small) seemed to be wasteful. And then it occurred to me that it would make much more sense to just make the skip-list functionality equivalent to the "ignore" message type.

It just occurred to me, however, that one thing is possibly surprising with either version of the skip list functionality: if a certain object is corrupt on disk, it cannot be skipped via the skip-list, as the object is *still* unpacked (which would fail in the case of a corrupt object).

I will document that in the man page.

Ciao,
Dscho
