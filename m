From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v1 22/45] archive: convert to use parse_pathspec
Date: Sat, 16 Mar 2013 22:00:12 -0700
Message-ID: <7vehfetycj.fsf@alter.siamese.dyndns.org>
References: <1363327620-29017-1-git-send-email-pclouds@gmail.com>
 <1363327620-29017-23-git-send-email-pclouds@gmail.com>
 <7vfvzwv96b.fsf@alter.siamese.dyndns.org>
 <CACsJy8DUb5j0of=cuQje5cRWLwyi-MiH-d-RsyBiPOjaD1Tntg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Sun Mar 17 06:00:53 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UH5iF-0006tG-1I
	for gcvg-git-2@plane.gmane.org; Sun, 17 Mar 2013 06:00:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750805Ab3CQFAQ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 17 Mar 2013 01:00:16 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:53281 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750713Ab3CQFAP convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 17 Mar 2013 01:00:15 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id D6FE88567;
	Sun, 17 Mar 2013 01:00:14 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=quG6x3PXcRf/
	HzTC03IwBWdKMhI=; b=pIKrfHKZwA00Pzxc8NwIuaKdZnmyRNKtF8ra6L1eYQLN
	N7/NJWEpAvUiU+nn4wXCxijUaHtI6lzAXqRBYcP4dj8NhobNQOOiY9AaHAqfsIkB
	Xuj5uCJjWpNswEJ5YsMuPGLC6fdsvx7chjaoNCixuJSJ6ZqMioV904X79NhhN4Y=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=QJW6Fj
	+xktwoEIFSb15rKoDDgxIC8lIDN776M9MjQ9GMlKIG+ugO7gZW6wYlSyFNzJIB7D
	en0Wf3eQVTalW0kxzS+nW+/V1Wbzt8FPr46DHPuJ50kqET2sP7rv5XVIwC0+xrEH
	X5oKRDwpHnubzuVsbfq73W6kjE/8YuuDRqAxI=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id CB3CF8565;
	Sun, 17 Mar 2013 01:00:14 -0400 (EDT)
Received: from pobox.com (unknown [24.4.35.13]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 49B608564; Sun, 17 Mar 2013
 01:00:14 -0400 (EDT)
In-Reply-To: <CACsJy8DUb5j0of=cuQje5cRWLwyi-MiH-d-RsyBiPOjaD1Tntg@mail.gmail.com> (Duy
 Nguyen's message of "Sat, 16 Mar 2013 08:08:29 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 8DC777BA-8EBF-11E2-A43D-4AAA2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/218328>

Duy Nguyen <pclouds@gmail.com> writes:

> On Sat, Mar 16, 2013 at 12:56 AM, Junio C Hamano <gitster@pobox.com> =
wrote:
>> Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy  <pclouds@gmail.com> write=
s:
>>
>>> @@ -232,11 +228,18 @@ static int path_exists(struct tree *tree, con=
st char *path)
>>>  static void parse_pathspec_arg(const char **pathspec,
>>>               struct archiver_args *ar_args)
>>>  {
>>> -     ar_args->pathspec =3D pathspec =3D get_pathspec("", pathspec)=
;
>>> +     /*
>>> +      * must be consistent with parse_pathspec in path_exists()
>>> +      * Also if pathspec patterns are dependent, we're in big
>>> +      * trouble as we test each one separately
>>> +      */
>>> +     parse_pathspec(&ar_args->pathspec, 0,
>>> +                    PATHSPEC_PREFER_FULL,
>>> +                    "", pathspec);
>>>       if (pathspec) {
>>>               while (*pathspec) {
>>>                       if (!path_exists(ar_args->tree, *pathspec))
>>> -                             die("path not found: %s", *pathspec);
>>> +                             die(_("pathspec '%s' did not match an=
y files"), *pathspec);
>>>                       pathspec++;
>>>               }
>>
>> You do not use ar_args->pathspec even though you used parse_pathspec=
()
>> to grok it?  What's the point of this change?
>
> parse_pathspec() here is needed because write_archive_entries needs i=
t
> later.

That is not the issue I was pointing out.  Even though you parse the
pathspec into args->pathspec, the "if() { while () {} }" here still
uses strings contained in **pathspec, as if they are literal strings
and not ":(glob)Documentation" and such, and will not match the named
directory.

Technically, erroring out saying "':(glob)Documentation' does not exist
as a path in the tree" is correct, but it would be nicer to have the
code inspect parse_pathspec() result and independently barf, saying
"this command does not support magic pathspecs, give me leading paths
and nothing else", until we do support magic pathspecs, no?
