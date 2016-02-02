From: Junio C Hamano <gitster@pobox.com>
Subject: Re: parse_object does check_sha1_signature but not parse_object_buffer?
Date: Tue, 02 Feb 2016 11:25:44 -0800
Message-ID: <xmqqwpqmsymf.fsf@gitster.mtv.corp.google.com>
References: <20160202015701.GA30444@glandium.org>
	<xmqq60y7u7sj.fsf@gitster.mtv.corp.google.com>
	<20160202043628.GA10253@glandium.org>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Mike Hommey <mh@glandium.org>
X-From: git-owner@vger.kernel.org Tue Feb 02 20:26:02 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aQgaM-0001Wh-G3
	for gcvg-git-2@plane.gmane.org; Tue, 02 Feb 2016 20:25:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754939AbcBBTZy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Feb 2016 14:25:54 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:65339 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753880AbcBBTZx (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Feb 2016 14:25:53 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 578FD3F99B;
	Tue,  2 Feb 2016 14:25:47 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=K1PEIMd90DqAAf3Djof7NsBZwug=; b=RwGhzU
	ggSXPRnqvdRgYK17hd7HO3/Y2pVx+B/Q+ZB+e1yLYG7J2/9Gf1XCn/imGTbYEEkW
	9PhrqcWFRLkPfxCZwdQ1sjIXZhLKf0Sa8eKFxsssnVOtQyvnwZKI4MDOZCcJ5GDa
	NF7dlCV/e1ec8fU80YaYT/d+RocCecVKLMNOc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=X5+kuw8TQfX/cK7ygquV6wFrXqavi8zi
	G5FqTuYqzqhQ0LbYHrsq0OO4GJI8sw0XI71YK3klq3ZXjtB9a7u9CIj5KJrbnXhR
	3DLk/Z2AI5yflB4DUZGhFhuer8JHfPYaWSOd+vW4Isype2WiqcR5TBL4+otQ18Vf
	0LfBk5qt4ks=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 41F7A3F99A;
	Tue,  2 Feb 2016 14:25:47 -0500 (EST)
Received: from pobox.com (unknown [216.239.45.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 9A0FC3F998;
	Tue,  2 Feb 2016 14:25:46 -0500 (EST)
In-Reply-To: <20160202043628.GA10253@glandium.org> (Mike Hommey's message of
	"Tue, 2 Feb 2016 13:36:28 +0900")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: C26DEF56-C9E2-11E5-A425-04C16BB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/285299>

Mike Hommey <mh@glandium.org> writes:

> On Mon, Feb 01, 2016 at 07:10:04PM -0800, Junio C Hamano wrote:
>> Mike Hommey <mh@glandium.org> writes:
>> 
>> > Shouldn't parse_object_buffer also do check_sha1_signature?
>> 
>> In general, it shouldn't; its callers are supposed to do it as
>> additional check when/if needed.  Callers like the one in fsck.c
>> does not want to die after seeing one bad one.  We want to report
>> and keep checking other things.
>
> Shouldn't some things like, at least, `git checkout`, still check
> the sha1s, though?

That is a different issue--my answer was about the quoted question
regarding parse_object_buffer().  Its callers are supposed to do
additional check when/if needed, and there may be codepaths that
currently use parse_object_buffer() that may want to do their own
check, or call a different function that does the check for them.

Having said that, I do not necessarily think "git checkout" should
revalidate the object name.  The repository that you use for your
daily work would have the same error/corruption rate as your working
tree files, and I do not think you would constantly "validate" what
is in your working tree by comparing their contents with what you
think ought to be there.

If you are working on extremely poor quality disks and SSDs, it
might make sense to constantly revalidating the object data to catch
corruption early, as that is what we can do (as opposed to the
working tree files, corruption to which you probably do not have
anything to catch bitflipping on).

Unless you are placing your working tree on a filesystem with
checksums, but your object data would also be protected against
corruption in that case, so an extra revalidation at "git checkout"
time would not buy you much if anything at all.

http://article.gmane.org/gmane.comp.version-control.git/283380 (not
necessarily the entire thread, but that exact article) is a
reasonable summary that illustrates the way how we view the object
integrity.

    So "index-pack" is the enforcement point, and the rest of the
    git commands generally assume that we can trust what is on disk
    (as it is has either been generated by us, or checked by
    index-pack).  The rest of the commands do not spend time
    checking that the on-disk contents are sane (though you can run
    git-fsck if you want to do that).

If anything, we may want to reduce the number of codepaths that
calls check_sha1_signature() on data that we know we have read from
our own repository.  Even though I am not opposed to an idea to have
a "paranoid" mode that revalidates the object name every time (and
if "git checkout" does not currently, allow it to revalidate when we
are operating under the "paranoid" mode), I do not think it should
be on by default.

In fact, I have this suspicion that the original justification to
have the call to check_sha1_signature() in parse_object() might have
been invalidated by the restructuring of the code over the past 10
years.  e9eefa67 ([PATCH] Add function to parse an object of
unspecified type (take 2), 2005-04-28) says

    It also checks the hash of the file, due to its heritage as part
    of fsck-cache.

I.e. we do not need this call here, as long as we make sure that
fsck codepath does not depend on the fact that parse_object() calls
check_sha1_signature() to validate the consistency between the data
and the object name.

In fact, we do this, which is quite suboptimal:

        static int fsck_sha1(const unsigned char *sha1)
        {
                struct object *obj = parse_object(sha1);
                if (!obj) {
                        errors_found |= ERROR_OBJECT;
                        return error("%s: object corrupt or missing",
                                     sha1_to_hex(sha1));
                }
                obj->flags |= HAS_OBJ;
                return fsck_obj(obj);
        }

This function is called for each loose object file we find in
fsck_object_dir(), and there are a few problems:

 * The function parse_object() called from here would issue an error
   message and returns NULL; then you get another "corrupt or
   missing" error message, because this code cannot tell from the
   NULL which is the case.

 * The intent of the callchain to fsck_sha1() is to iterate over
   loose object files xx/x{38} and validate what is contained in
   them, but that behaviour is not guaranteed because it calls
   parse_object(), which may get the object data from a packfile
   if the loose object is also in the packfile.

This function should instead take "path" (the only caller of this
function fsck_loose() has it), read the data in the file, hash the
data to validate that it matches "sha1" and then create the object
out of that data it read by calling parse_object_buffer().

I didn't check other callers of parse_object(), but I doubt that
they need or want a check_sha1_signature() call in the function.
