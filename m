From: Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH v6 01/19] fsck: Introduce fsck options
Date: Sat, 20 Jun 2015 14:33:41 +0200
Organization: gmx
Message-ID: <792e5fab01e2fc7f156b8d0123364acf@www.dscho.org>
References: <cover.1434657920.git.johannes.schindelin@gmx.de>
 <cover.1434720655.git.johannes.schindelin@gmx.de>
 <1befa0a0f1feead1ef9b332bdb175182db1c4b4c.1434720655.git.johannes.schindelin@gmx.de>
 <xmqqd20r8qrm.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, mhagger@alum.mit.edu, peff@peff.net
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Jun 20 14:34:10 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z6HyI-0004cM-9o
	for gcvg-git-2@plane.gmane.org; Sat, 20 Jun 2015 14:34:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754084AbbFTMeA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 20 Jun 2015 08:34:00 -0400
Received: from mout.gmx.net ([212.227.17.20]:63319 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754051AbbFTMd7 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 20 Jun 2015 08:33:59 -0400
Received: from www.dscho.org ([87.106.4.80]) by mail.gmx.com (mrgmx103) with
 ESMTPSA (Nemesis) id 0MGip3-1ZJEG6244v-00DXK3; Sat, 20 Jun 2015 14:33:43
 +0200
In-Reply-To: <xmqqd20r8qrm.fsf@gitster.dls.corp.google.com>
X-Sender: johannes.schindelin@gmx.de
User-Agent: Roundcube Webmail/1.1.0
X-Provags-ID: V03:K0:fL9xcMGNW7W42UtOJ+LcHutPhO6ebEUec5nggdY42pCHB0Ju/Uv
 eLHH8DZGao0u8AEsmss5vysRurZwxTI3sTw2bJ3OmCJEJeSdAW7vcJXTjyXFQYQY8GYG3wH
 dVs6/ojjOmUlS8txz7SrF1q5Hk6tmVNuzSoUuCz3DfEt2rruH0d546uTvoXcxJPZPXWKjve
 XTC9iPyAvQ42ZqQoQGpdg==
X-UI-Out-Filterresults: notjunk:1;
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/272226>

Hi Junio,

On 2015-06-19 21:03, Junio C Hamano wrote:
> Johannes Schindelin <johannes.schindelin@gmx.de> writes:
> 
>> diff --git a/builtin/index-pack.c b/builtin/index-pack.c
>> index 48fa472..87ae9ba 100644
>> --- a/builtin/index-pack.c
>> +++ b/builtin/index-pack.c
>> @@ -75,6 +75,7 @@ static int nr_threads;
>>  static int from_stdin;
>>  static int strict;
>>  static int do_fsck_object;
>> +static struct fsck_options fsck_options = FSCK_OPTIONS_STRICT;
> 
> So there is a global fsck_options used throughout the entire
> session here.
> 
>> @@ -838,10 +839,10 @@ static void sha1_object(const void *data, struct object_entry *obj_entry,
>>  			if (!obj)
>>  				die(_("invalid %s"), typename(type));
>>  			if (do_fsck_object &&
>> -			    fsck_object(obj, buf, size, 1,
>> -				    fsck_error_function))
>> +			    fsck_object(obj, buf, size, &fsck_options))
>>  				die(_("Error in object"));
> 
> And that is used here to inspect each and every object we encounter.
> 
>> -			if (fsck_walk(obj, mark_link, NULL))
>> +			fsck_options.walk = mark_link;
> 
> Then we do a call to fsck_walk() starting from this object, letting
> mark_link() to inspect it and set the LINK bit.
> 
>> +			if (fsck_walk(obj, NULL, &fsck_options))
>>  				die(_("Not all child objects of %s are reachable"), sha1_to_hex(obj->sha1));
> 
> Since nobody else sets fsck_options.walk to any other value, and
> nobody else calls fsck_walk(), shouldn't that assignment be done
> only once somewhere a lot higher in the callchain?  The apparent
> "overriding while inspecting this object" that does not have any
> corresponding "now we are done, so revert it to the original value"
> puzzled me, and I am sure it would puzzle future readers of this
> code.

Good point. I guess I was really wary that a configured walk function might change the behavior of `fsck_object()`. But after inspecting the code paths carefully, I conclude that the walk function is really only used in the `fsck_walk_*()` family of functions.

I changed that locally, will be part of v7.

Ciao,
Dscho
