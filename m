From: Junio C Hamano <gitster@pobox.com>
Subject: Re: What's cooking in git.git (Nov 2013, #01; Fri, 1)
Date: Mon, 04 Nov 2013 10:07:03 -0800
Message-ID: <xmqq4n7s11o8.fsf@gitster.dls.corp.google.com>
References: <xmqqob6320rt.fsf@gitster.dls.corp.google.com>
	<20131103191533.GC7462@pvv.ntnu.no>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Torstein Hegge <hegge@resisty.net>
X-From: git-owner@vger.kernel.org Mon Nov 04 19:07:19 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VdOYX-0002e6-IR
	for gcvg-git-2@plane.gmane.org; Mon, 04 Nov 2013 19:07:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754793Ab3KDSHJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 4 Nov 2013 13:07:09 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:54275 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753889Ab3KDSHH (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 4 Nov 2013 13:07:07 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id EE8114CCD3;
	Mon,  4 Nov 2013 13:07:06 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=gfdZEOh9n/3xglybq2Ovz+Yzgek=; b=vBmMHQ
	75mOt+SrFrwFFir+kXgkQKuIb+zjPQC+4jsDOcWQeIvG5p26mgAaIWyCC9aQ4A38
	IHTpxZkR58Ib4mgn8itxODt7/y5YZdy97B6lopx2U+4x/zCjzKfKh7fv4OzFKQiX
	HV3+E56IMKvqDyy/6CXdI3Bpv4v4XmM9DleHs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=U1TCXsEeIjyOYKAjHJ9noYfLhoBRFJIM
	wB9DL2icxCV+f8P6Vbd67CaIQij1HbckwcC4wV1yM0VIKJ4dUww82qLHHphhZXFV
	eioRvaCzZDsxDLWcp6YriElmsn9tA+bQYT3u865FylyH5NkXkEY+CKBgaFJJFO1v
	i0wYAspnMpo=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id DF9234CCD2;
	Mon,  4 Nov 2013 13:07:06 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 235734CCCF;
	Mon,  4 Nov 2013 13:07:06 -0500 (EST)
In-Reply-To: <20131103191533.GC7462@pvv.ntnu.no> (Torstein Hegge's message of
	"Sun, 3 Nov 2013 20:15:33 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: EA113D3A-457B-11E3-AA09-1FFB7F2839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/237292>

Torstein Hegge <hegge@resisty.net> writes:

> On Fri, Nov 01, 2013 at 15:52:06 -0700, Junio C Hamano wrote:
>> * th/reflog-annotated-tag (2013-10-28) 1 commit
>>   (merged to 'next' on 2013-11-01 at 8b154cc)
>>  + reflog: handle lightweight and annotated tags equally
>> 
>>  "git log -g $annotated_tag", when there is no reflog history, should
>>  have produced a single output entry (i.e. the ref creation event),
>>  but instead showed the history leading to the tag.
>
> This isn't really what th/reflog-annotated-tag does, 
> "git log -g $annotated_tag" now produces no output.
>
> Is the proper behavior to output the ref creation event? In that case,
> should the same happen for lightweight tags?
>
> Or am I missing something related to "when there is no reflog history"?

I actually meant, by "no reflog history", "created once and then
never updated".

But I think we first need to see if you are testing the right thing.

In a freshly created empty directory, do this:

    $ git init
    $ git commit --allow-empty -m initial
    $ git tag test master
    $ git tag -a -m 'anno' anno master
    $ find .git/logs/ -ls

For me, this does not give me any log for tags (as expected,
actually).  To have reflgos for these two tags, we need to do this
instead (you can do these, continuing from the above):

    $ git tag -d test anno
    $ mkdir .git/logs/refs/tags
    $ >.git/logs/refs/tags/test
    $ git tag test master
    $ >.git/logs/refs/tags/anno
    $ git tag -a -m 'anno' anno master
    $ find .git/logs/ -ls
    $ grep . .git/logs/refs/tags/* .git/logs/refs/heads/*

The last one shows that we now have one reflog entry each for our
lightweight and annotated tags, and the master branch also has one
reflog entry.  Now we can really try things out.

    $ git log -g master
    $ git log -g test
    $ git log -g anno

The first two should obviously show the same, but now I think about
it, I am not sure what the last one should produce.  If we further
did this:

    $ git tag -f -a -m 'annotree' anno master^{tree}

what should "git log -g" show?

After all, "log -g" (and hence "reflog") takes over the usual
history walking machinery and overrides it with a hack that assumes
that any objects it would see in the reflog entries are commits (at
least, it assumes they can be formatted with the usual codepath to
pretty-print commits).  There is no way for the current code (with
the patch under discussion, that lifts "we deal only with commits")
to magically work with a tag that points at a tree or a blob, like
this last example.

I am afraid that merging that single-liner patch was a mistake. To
fix the funkiness of showing "log -g" on tags, we need a lot more
than that.

Will kick the topic back to 'pu' (or at least, during this feature
freeze period, will backburner it and not let it graduate out of
'next').

Thanks.


    
