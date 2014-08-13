From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 3/3] checkout -m: attempt merge when deletion of path was staged
Date: Wed, 13 Aug 2014 10:48:56 -0700
Message-ID: <xmqqzjf82sc7.fsf@gitster.dls.corp.google.com>
References: <xmqqha1h60fy.fsf@gitster.dls.corp.google.com>
	<1407878107-22850-1-git-send-email-stefanbeller@gmail.com>
	<20140812235731.GD24621@google.com>
	<20140813000317.GG24621@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Stefan Beller <stefanbeller@gmail.com>, Johannes.Schindelin@gmx.de,
	barkalow@iabervon.org, git@vger.kernel.org
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Wed Aug 13 19:49:15 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XHcfg-0000s0-In
	for gcvg-git-2@plane.gmane.org; Wed, 13 Aug 2014 19:49:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752923AbaHMRtI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 Aug 2014 13:49:08 -0400
Received: from smtp.pobox.com ([208.72.237.35]:50308 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752073AbaHMRtH (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Aug 2014 13:49:07 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 5D51C31DE9;
	Wed, 13 Aug 2014 13:49:06 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=sQfBPo/qM99H5yhgfRUkS6FW8Wo=; b=BZtbYo
	vMem5cYHtTG9sBoSKBlZO7PUmCBjiZwBwJFZDgbHsq9tIQKkF1hzPUgsY3sOHeH8
	fut+4qsdcHvBRhthe/a1BFyzZho3t4Ps9TP40DSBU6hkclrJdhiWPgIRNSltuqVs
	LCGDoMIbjGXamvYTVkQDeJ8mfoWHcKcd5PGoM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=mXeVjwYj9AsuXtydo6KJUACKDwjFDRJy
	mry1//iuVA0CWYDMsdcmJ5fRbkZoG984utijCeVcZ9+k63sYk7jsOOe8aluqKypV
	yKU4kD1PwjzRGRENnuMA3AMXHwY+a0wFPsDkxHlEjbfm8fJ1cngqau5HfjLKlbMk
	8lrlrMNeo9E=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 5293831DE8;
	Wed, 13 Aug 2014 13:49:06 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 4F91D31DD5;
	Wed, 13 Aug 2014 13:48:58 -0400 (EDT)
In-Reply-To: <20140813000317.GG24621@google.com> (Jonathan Nieder's message of
	"Tue, 12 Aug 2014 17:03:18 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 1A358F56-2312-11E4-81B0-9903E9FBB39C-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/255222>

Jonathan Nieder <jrnieder@gmail.com> writes:

> twoway_merge() is missing an o->gently check in the case where a file
> that needs to be modified is missing from the index but present in the
> old and new trees.  As a result, in this case 'git checkout -m' errors
> out instead of trying to perform a merge.

I see two hunks in threeway_merge(), so two existing callers there
will not change their behaviour.  Two hunks in twoway_merge() means
that among three existing callers in that function, this one at the
end (not shown in your patch) changes its behaviour:

	else if (newtree) {
		if (oldtree && !o->initial_checkout) {
			/*
			 * deletion of the path was staged;
			 */
			if (same(oldtree, newtree))
				return 1;
			return reject_merge(oldtree, o);
		}
		return merged_entry(newtree, current, o);
	}
	return deleted_entry(oldtree, current, o);

> This is the most iffy of the three patches, mostly because I was too
> lazy to write a test.

You would trigger this codepath by jumping from an old revision to a
new revision after "git rm $path" any path that has been modified
between the two.  The only behaviour difference is that it will stop
issuing an error message---the "checkout -m" will successfully switch
between the revs and leave the index in a "we modified, they removed"
conflicting state with or without your patch.
