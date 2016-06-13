From: Junio C Hamano <gitster@pobox.com>
Subject: Re attr API further revamp
Date: Mon, 13 Jun 2016 13:55:43 -0700
Message-ID: <xmqqtwgwbygg.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Stefan Beller <sbeller@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jun 13 22:56:10 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1bCYtm-0006T3-4n
	for gcvg-git-2@plane.gmane.org; Mon, 13 Jun 2016 22:55:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423283AbcFMUzt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 13 Jun 2016 16:55:49 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:62774 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1422870AbcFMUzr (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 13 Jun 2016 16:55:47 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 23F1525D09;
	Mon, 13 Jun 2016 16:55:46 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:date:message-id:mime-version:content-type; s=sasl; bh=4
	9ltcLqNW2pDhi0he/pP7HqKm4s=; b=UN70koPYXGh1F6Oz7yeSLHvrcZGPe+feS
	TqWql/djUqlMLHloKAYDbFRTsyJ6ZmW99SCTYSm7Y/C0ZV1UDA43lJls108zfQhw
	ZYpS/jmuoguMbKo57VBmc+TgX37gc0oWHHXwpDMgMBgbV41+iIOn1PiZiug+p1G0
	LLTGf0lvTY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:date:message-id:mime-version:content-type; q=dns; s=
	sasl; b=uFafU9Tcn30l1p89+rzJo8Q+fVFlSt7VWSI6/BxNrRnV1HtdbcyrrbnS
	HIZ6fd05o1DKyHmpqWmmRxJ4h/2T8f5GsfaN7QHDw4yB89rU7Q1NaFGhiao8TJV4
	eQTbK4s7uoS0wR2OMDQWUEPWL3A6enD8oMaYlEVH3uO92uhPq9U=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 1C7BF25D08;
	Mon, 13 Jun 2016 16:55:46 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 9479725D03;
	Mon, 13 Jun 2016 16:55:45 -0400 (EDT)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 32FF5448-31A9-11E6-A8F5-89D312518317-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/297244>

I hate to be doing this, but we need yet another revamp to the attr
API that affects all the callers.

In the original design, a codepath that wants to check attributes
repeatedly for many paths (e.g. "convert" that wants to see what
crlf, ident, filter, eol and text attributes are set to for paths
that it is asked to munge the blob contents for) used to allocate

	static struct git_attr_check {
        	struct git_attr *attr;
                const char *value;
	} ccheck[NUM_ATTRS];

and populated the array when the first time the codepath was
entered, e.g.

	if (!ccheck[0].attr) {
        	for (i = 0; i < NUM_ATTRS; i++)
                	ccheck[i].attr = git_attr(...);
	}

and then make a call to the API to ask for these attributes in
ccheck[] for a path, i.e.

	git_attr_check(path, NUM_ATTRS, ccheck);

The API function will fill in the ccheck[].value fields and the
caller will read from there how each attribute is set for the path.

This was updated with recent jc/attr topic so that attr_check
structure can be enriched to keep _more_ state, such as the
pre-parsed representation of all the contents of the relevant
.gitattributes files, which currently is held in a program-side
singleton instance called attr_stack, partly in preparation for
Stefan's sb/pathspec-label topic that is expected to place a lot
heavier load to the attribute subsystem.

A caller of the API after that update would do more like

  	static struct git_attr_check *ccheck;

	if (!ccheck)
        	ccheck = git_attr_check_initl(...);
	git_attr_check(path, ccheck);
	for (i = 0; i < NUM_ATTRS; i++)
        	if (ccheck->check[i].value == ATTR_UNSET)
			... do the Unset thing ...

This however is not thread-safe for obvious two reasons.

 * Two threads can simultanously enter this section of the code and 
   end up initializing ccheck twice;

 * Even though ccheck[].attr are constant for the purpose of this
   codepath (i.e. all threads passing through are interested in
   checking the same set of attributes), ccheck[].value fields
   cannot be shared across simultaneous threads like the above
   snippet does.

So it appears that the final API visible from the callers needs to
be updated further, perhaps something like:


	static struct git_attr_check *ccheck;
	const char *values[NUM_ATTRS];

	git_attr_check_initl(&ccheck, "crlf", "ident", ..., NULL);
	git_attr_check(path, ccheck, values);

where git_attr_check_initl() would do the "if ccheck is NULL then
initialize it to an instance" atomically in threading environment,
and git_attr_check() returns its finding to values[] array the
calling thread exclusively owns, while sharing the input ccheck
and the list of attributes the call inquires among threads.

Also unlike the earlier plan, attr_stack aka "where in the directory
hierarchy are we asking attributes for?" will not be stored directly
in git_attr_check structure.  It is likely that a thread-local
structure will be introduced hidden behind this API (i.e. the
callers do not have to be aware of it), and attr_stack will be
registered in this thread-local structure keyed by &ccheck, so that
<thread, callsite> pair can have attr_stack instance of its own.

This is because a single attr_stack per ccheck will not work as an
optimization mechanism when multi-threaded.  Two threads may be
running the same convert() function, and they may be interested in
the same set of attributes (e.g. "crlf", "ident", etc.) but they
will be working on different parts of the tree, so having attr_stack
per <thread, callsite> would make more sense.

All of which will be quite a lot of work, though, so do not expect
that it will appear by the end of this week ;-)

Thanks.
