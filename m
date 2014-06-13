From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: [PATCHv2 3/6] verify-commit: scriptable commit signature verification
Date: Fri, 13 Jun 2014 13:45:58 +0200
Message-ID: <539AE476.4030205@drmicha.warpmail.net>
References: <cover.1402655838.git.git@drmicha.warpmail.net> <48984553eb1d9ac53dd4b9604af568e22c735109.1402655839.git.git@drmicha.warpmail.net> <20140613111945.GC14066@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Jun 13 13:46:08 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WvPvr-0002Uf-2W
	for gcvg-git-2@plane.gmane.org; Fri, 13 Jun 2014 13:46:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751517AbaFMLqB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 13 Jun 2014 07:46:01 -0400
Received: from out2-smtp.messagingengine.com ([66.111.4.26]:48910 "EHLO
	out2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751082AbaFMLqA (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 13 Jun 2014 07:46:00 -0400
Received: from compute4.internal (compute4.nyi.mail.srv.osa [10.202.2.44])
	by gateway1.nyi.mail.srv.osa (Postfix) with ESMTP id 17105209C1;
	Fri, 13 Jun 2014 07:46:00 -0400 (EDT)
Received: from frontend2 ([10.202.2.161])
  by compute4.internal (MEProxy); Fri, 13 Jun 2014 07:46:00 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=message-id:date:from:mime-version:to:cc
	:subject:references:in-reply-to:content-type
	:content-transfer-encoding; s=smtpout; bh=E0nsx5MyVNY2dY8yEqhBo9
	AEuU4=; b=YnLr14ExKSDCaSCttodUZBvwMgSVmsow/8qDJyQaSNKyr+M91hijhP
	24iNkDX/WaI1r+8pUpDI0fuTwzBs5wxsClfs3nqgicwJBjc058o+oK/tlosC9Ywc
	iqQaRvGAK8xKTvAQv6gWvh6xJtmThY3Vz9H0qAN1pCEYYPVcgGDrc=
X-Sasl-enc: e8LKbhJx0cwC6acwrokigvH2m+kx7znmsjFT1pynpBFQ 1402659959
Received: from localhost.localdomain (unknown [130.75.46.56])
	by mail.messagingengine.com (Postfix) with ESMTPA id 6502E6800F8;
	Fri, 13 Jun 2014 07:45:59 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:24.0) Gecko/20100101 Thunderbird/24.5.0
In-Reply-To: <20140613111945.GC14066@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/251549>

Jeff King venit, vidit, dixit 13.06.2014 13:19:
> On Fri, Jun 13, 2014 at 12:42:45PM +0200, Michael J Gruber wrote:
> 
>> +
>> +	free(signature_check.gpg_output);
>> +	free(signature_check.gpg_status);
>> +	free(signature_check.signer);
>> +	free(signature_check.key);
>> +	return signature_check.result != 'G';
>> +}
> 
> How about .payload here?

I sneekily fix this in 6/6... I thought 3/6 is on next already, too late
for a real v2. Otherwise I would put 6/6 before everything else.

>> +	type = sha1_object_info(sha1, NULL);
>> +	if (type != OBJ_COMMIT)
>> +		return error("%s: cannot verify a non-commit object of type %s.",
>> +				name, typename(type));
>> +
>> +	buf = read_sha1_file(sha1, &type, &size);
>> +	if (!buf)
>> +		return error("%s: unable to read file.", name);
> 
> I think you can drop the sha1_object_info call and just check "type"
> from read_sha1_file (they _should_ agree, but if they do not, I'd rather
> pay attention to the one that came along with the buffer). And this is
> the uncommon error path, so expanding the object into memory before we
> die is not a big deal.
> 
> Should this peel to a commit if given a tag? I'd say probably. I know
> you raised the issue elsewhere of keeping things simple, but I think if
> you are calling verify-commit, you know you want a commit, and we should
> treat the argument as a commit-ish. Anyway, if you go that route, then
> lookup_commit_or_die is probably what you want.
> 
> Also, minor nit, but we typically do not end the error messages with a
> full stop (we've been rather inconsistent in the past, but these days
> seem to mostly settle on no punctuation).
> 
> -Peff

Both of these issues actually come for following verify-tag as closely
as possible. If 3 is not applied already, I should do away with
sha1_object_info.

About the peeling I'm not so sure, since there's a difference between a
signed tag pointing to a commit and a signed commit. Since
verify-{tag,commit} are bare metal plumbing, I would expect callers to
use <rev>^{commit} explicitly if they don't care how <rev> peels to a
commit.

Michael
