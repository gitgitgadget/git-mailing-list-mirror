From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [WIP PATCH 0/5] support --exclude for diff/log commands
Date: Tue, 22 Mar 2011 16:59:58 -0700
Message-ID: <7v7hbqk8ox.fsf@alter.siamese.dyndns.org>
References: <1299726819-5576-1-git-send-email-pclouds@gmail.com>
 <7vmxl37bdp.fsf@alter.siamese.dyndns.org>
 <7vvczr5pw6.fsf@alter.siamese.dyndns.org>
 <AANLkTimsv9bO+Go6Mqrrp_1-AZ=sC3ndyAuskPYLVbkv@mail.gmail.com>
 <AANLkTimWPoMEYdLCwTTit6AeuJegOc96gE1JsO8B4fh=@mail.gmail.com>
 <4D871E51.8090106@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Nguyen Thai Ngoc Duy <pclouds@gmail.com>, git@vger.kernel.org
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Wed Mar 23 01:00:36 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q2BV5-0008Nr-Sy
	for gcvg-git-2@lo.gmane.org; Wed, 23 Mar 2011 01:00:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755784Ab1CWAAS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 22 Mar 2011 20:00:18 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:60647 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755125Ab1CWAAQ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 Mar 2011 20:00:16 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 978634489;
	Tue, 22 Mar 2011 20:01:51 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Lr5T7z+zlbsRh1f28qOqptd+Sbw=; b=UCZFsL
	yRhw9+hTio5K6Khp0ah06i12USfFY1VBMIAVL3+OkS1EJRpUpjXELjKOpVyYgF74
	05bNIddKhcIVKuydbo1Lco0XOoZoxceFVoBfrKC7Adh/ult96PBFjXKjtJWi3ynf
	0nP+RKQYd1RfzJB+ll0FzSLxSilBEKmVgPHIk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=x9bVyABwy7eq4fwhv6VZBmL57X9Fxj83
	W4LNkkqqIOsL11fhZHYag9pJkrYw3peH03F3rE+8c5UplUgAxnrpe8dDUz0OdYMK
	qiFEtDTPYz4uAtQb4PqhLq4+XQQsOkU7M7O3bZpz6LyRhFNrU4jM3eMFB4/EaTvY
	WTodHenZ65k=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 64D4C447B;
	Tue, 22 Mar 2011 20:01:47 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 2B193446C; Tue, 22 Mar 2011
 20:01:40 -0400 (EDT)
In-Reply-To: <4D871E51.8090106@drmicha.warpmail.net> (Michael J. Gruber's
 message of "Mon, 21 Mar 2011 10:45:53 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: BEE5C25E-54E0-11E0-B371-E8AB60295C12-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/169787>

Michael J Gruber <git@drmicha.warpmail.net> writes:

>> One thing that makes it different from Michael's approach is, :/foo
>> will match ':/foo' literally in every directories and foo at top-tree.
>> I feel mildly uncomfortable with it, but it makes it consistent with
>> other wildcards. If no one objects, I'll try to make a patch with this
>> approach.
>
> Maybe I misunderstand which topic you are referring to. I have a patch
> for ":" (to denote repo-root in pathspecs), there's no need to make
> another one for ":/". (I would really prefer to do it myself since I
> brought it up.) I was just waiting for agreement to settle in about
> which prefix to use.

I am not sure if there is any disagreement in the desired semantics
between the two.

Let's clarify by dumping my understanding of what we aim to achieve.

 - The user gives ':/<frotz>' and '<xyzzy>' from the command line, in a
   subdirectory.

 - Internally we chdir() up to the top of the working tree, and the prefix
   is set to the path to the subdirectory (with trailing slash);
   get_pathspec(prefix, pathspec) is called, where pathspec is often a
   later part of argv[] we got from the command line.

 - Currently, get_pathspec() gives either:

    - the same as incoming pathspec, if <prefix> is NULL (this happens at
      the root of the working tree);

    - { <prefix>, NULL }, if the incoming pathspec array is empty; or

    - an array of strings taken from pathspec, each prefixed with <prefix>.

   The list of the resulting strings is the pathspec, relative to the root
   of the working tree, and is used to determine if a path matches the
   given pathspec.  The match traditionally had two semantics (diff-tree
   family and everybody else, only the latter group knew about globs), but
   an earlier work by Nguyen has taught globs to everybody (at least it
   aimed to; we might have leftover cases that we haven't uncovered).

Both the ":/<path>" proposal (or your ":<path>" proposal) changes only a
very small part of the above, namely, "each prefixed with '<prefix>'" is
changed to if the element in original pathspec has the magic colon prefix,
the magic is stripped away, and the remainder becomes the element in the
resulting pathspec array without additional <prefix> in front.

If Nguyen's proposal is to also match ":/<path>" (or ":<path>") literally,
that part should be scrapped.  If somebody wants to match such an unusual
path component, it can always be expressed by quoting it as a glob,
i.e. "[:]/<path>" (or "[:]<path").

I am slightly in favor of ":<path>" syntax (than ":/<path>"), but I do not
care too deeply.  Either has the same problem that it will be confusing
with existing and well-established syntax (the former would conflict with
"name of the blob in the index", the latter with "name of the commit that
match the regexp).
