From: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
Subject: Re: [PATCH] Fix some sparse warnings
Date: Sat, 20 Jul 2013 20:26:27 +0100
Message-ID: <51EAE463.4010705@ramsay1.demon.co.uk>
References: <51E84F4E.3050600@ramsay1.demon.co.uk> <20130718203640.GB15735@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, Johannes Sixt <j6t@kdbg.org>,
	GIT Mailing-list <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sun Jul 21 15:06:58 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V0tLj-00030u-AR
	for gcvg-git-2@plane.gmane.org; Sun, 21 Jul 2013 15:06:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755456Ab3GUNGv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 21 Jul 2013 09:06:51 -0400
Received: from mdfmta005.mxout.tbr.inty.net ([91.221.168.46]:47428 "EHLO
	smtp.demon.co.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1755206Ab3GUNGu (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 21 Jul 2013 09:06:50 -0400
Received: from mdfmta005.tbr.inty.net (unknown [127.0.0.1])
	by mdfmta005.tbr.inty.net (Postfix) with ESMTP id DC0EDA647C0;
	Sun, 21 Jul 2013 14:06:49 +0100 (BST)
Received: from mdfmta005.tbr.inty.net (unknown [127.0.0.1])
	by mdfmta005.tbr.inty.net (Postfix) with ESMTP id 24AB7A647BF;
	Sun, 21 Jul 2013 14:06:49 +0100 (BST)
Received: from [193.237.126.196] (unknown [193.237.126.196])
	by mdfmta005.tbr.inty.net (Postfix) with ESMTP;
	Sun, 21 Jul 2013 14:06:46 +0100 (BST)
User-Agent: Mozilla/5.0 (Windows NT 5.1; rv:17.0) Gecko/20130620 Thunderbird/17.0.7
In-Reply-To: <20130718203640.GB15735@sigill.intra.peff.net>
X-MDF-HostID: 8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/230933>

Jeff King wrote:
> On Thu, Jul 18, 2013 at 09:25:50PM +0100, Ramsay Jones wrote:
> 
>> Sparse issues some "Using plain integer as NULL pointer" warnings.
>> Each warning relates to the use of an '{0}' initialiser expression
>> in the declaration of an 'struct object_info'. The first field of
>> this structure has pointer type. Thus, in order to suppress these
>> warnings, we replace the initialiser expression with '{NULL}'.
>>
>> Signed-off-by: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
> 
> Acked-by: Jeff King <peff@peff.net>
> 
> I thought at first we would need one more for the new callsite I added
> in my series, but we use memset() in that instance, so it is fine.

On an almost unrelated note ... I am now getting the following sparse
warnings:

    pack-revindex.c:105:23: warning: memset with byte count of 262144

This is a little annoying, since there is no way to turn this off. :(
(which I consider a bug in sparse).

Sparse has special-case code to check calls to memset(), memcpy(),
copy_to_user() and copy_from_user(). The code that checks the byte
count argument looks like:

static void check_byte_count(struct instruction *insn, pseudo_t count)
{
        if (!count)
                return;
        if (count->type == PSEUDO_VAL) {
                long long val = count->value;
                if (val <= 0 || val > 100000)
                        warning(insn->pos, "%s with byte count of %lld",
                                show_ident(insn->func->sym->ident), val);
                return;
        }
        /* OK, we could try to do the range analysis here */
}

I will just ignore this for now. ;-)

ATB,
Ramsay Jones
