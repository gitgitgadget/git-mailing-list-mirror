From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [WIP/PATCH v4 6/8] for-each-ref: rename some functions and make them public
Date: Mon, 01 Jun 2015 07:53:51 -0700
Message-ID: <xmqqvbf78oow.fsf@gitster.dls.corp.google.com>
References: <5569EF77.4010300@gmail.com>
	<1433008411-8550-6-git-send-email-karthik.188@gmail.com>
	<xmqqmw0kab94.fsf@gitster.dls.corp.google.com>
	<556B6234.2010809@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, christian.couder@gmail.com,
	Matthieu.Moy@grenoble-inp.fr
To: Karthik Nayak <karthik.188@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jun 01 16:54:07 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YzR6K-0003c5-N6
	for gcvg-git-2@plane.gmane.org; Mon, 01 Jun 2015 16:54:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752860AbbFAOxz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 1 Jun 2015 10:53:55 -0400
Received: from mail-ig0-f177.google.com ([209.85.213.177]:36650 "EHLO
	mail-ig0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751746AbbFAOxy (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 1 Jun 2015 10:53:54 -0400
Received: by igbpi8 with SMTP id pi8so63340900igb.1
        for <git@vger.kernel.org>; Mon, 01 Jun 2015 07:53:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=WoUX1L/42P6m4qS4peHjscZBTP6mBwUAMCYuNtG1KY8=;
        b=yY69//P/lYITKXAafUq6rAueBw8t81j4VeAgnxgp0gjd8oJmyXtRRzx6JEKT4c5oGq
         WN4Kgmd3PLMMrJGv2b1X0SbLSobQ/mISy+YXwi1eZwdTBN+cTtNZQXKayufvjSjsmYd1
         wp2WH88uDqF9EJ3Rwmsp2OXyJAh4J6UZUuEU7pljPqi1DOdomtcCsSAlK/EL1+vrolti
         jBdEltJIITtgTf30Om3lpyTTqx6uNsMBSjXHH125q2Mz1bDyNi8LeFnqFNEzPfO+69er
         5mBmdT6usO0Uhr9dzXUer374JRRtvrGamTN0q3WoZRy8yZEqXaTEjm6i8t5fFEPEfrHk
         O5bw==
X-Received: by 10.42.110.66 with SMTP id o2mr30232491icp.54.1433170433477;
        Mon, 01 Jun 2015 07:53:53 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:b0e6:ec48:f0c0:da4d])
        by mx.google.com with ESMTPSA id q10sm7952549ige.16.2015.06.01.07.53.52
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Mon, 01 Jun 2015 07:53:52 -0700 (PDT)
In-Reply-To: <556B6234.2010809@gmail.com> (Karthik Nayak's message of "Mon, 01
	Jun 2015 01:04:12 +0530")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/270419>

Karthik Nayak <karthik.188@gmail.com> writes:

> Could be achieved using a simple wrapper around 'filter_refs()'
> something like this perhaps.
>
> int filter_refs_with_pattern(struct ref_array *ref, int
> (*for_each_ref_fn)(each_ref_fn, void *), char **patterns)
> {
> 	int i;
> 	struct ref_filter_cbdata data;
> 	data.filter.name_patterns = patterns;
> 	filter_refs(for_each_ref_fn, &data);

I presume that this is

	filter_refs(&refs, for_each_ref_fn, &data);

as you would need to have some way to get the result back ;-)

> 	refs->nr = data.array.nr;
> 	for(i = 0; i < refs->nr; i++) {
> 		/* copy over the refs */
> 	}
> 	return 0;
> }
>
> Is this on the lines of what you had in mind? If it is, than I could
> just create a new patch which would make ref_filter_handler() private
> and introduce filter_refs() as shown.

Yeah.  Even though I suggested

	filter_refs(&for_each_ref, ...);

I actually would think the external interface should not mention
for_each_ref() like I did.  The primary reason why I felt that it is
bad for the API to export a generic callback function the caller can
use to call for_each_ref() or for_each_rawref()" in the longer term
is because it forces us to always iterate all refs; for_each_ref()
does not know what the callback filter function wants to do.  The
most common way to filter in the context of your GSoC project is "we
limit only to refs/heads/*, and then we may also filter by other
criteria" (that is "git branch" "-l" or possibly with "--contains",
etc.), and it is very wasteful for that codepath to allow
for_each_ref() to even enumerate and feed all refs outside the
refs/heads/* area to your callback, which would involve reading all
entries in packed-refs (which is a fixed cost so not an overhead)
and then reading everything in .git/refs/* (which is an overhead we
could and should avoid when we know we are only interested in the
branches that live in refs/heads*).

Your first implementation of course can just call for_each_ref() or
for_each_rawref(), and at the end of GSoC, the code may still do so.
But by keeping the external interface free of for_each_ref(), you
could later optimize.

And your above sample only takes for_each_ref_fn without exposing the
internal use of for_each_ref(), which is good.
