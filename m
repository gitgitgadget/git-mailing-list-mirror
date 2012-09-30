From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 8/9] longest_ancestor_length(): resolve symlinks
 before comparing paths
Date: Sun, 30 Sep 2012 01:00:25 -0700
Message-ID: <7vd314gcti.fsf@alter.siamese.dyndns.org>
References: <1348899362-4057-1-git-send-email-mhagger@alum.mit.edu>
 <1348899362-4057-9-git-send-email-mhagger@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jiang Xin <worldhello.net@gmail.com>,
	Lea Wiemann <lewiemann@gmail.com>, git@vger.kernel.org
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Sun Sep 30 10:00:44 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TIESA-0003S3-LU
	for gcvg-git-2@plane.gmane.org; Sun, 30 Sep 2012 10:00:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753213Ab2I3IAb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 30 Sep 2012 04:00:31 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:59692 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753199Ab2I3IA2 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 30 Sep 2012 04:00:28 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 67F739EE0;
	Sun, 30 Sep 2012 04:00:27 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=hRbkvvYLyAQ8TwOcgkbuoqyUv8w=; b=HjoGHB
	0ZF/+xaSzPtwSBhnkyeaIEPVcjvb8O6VNgsiTZz1srCpzjnkZ1vCx1uwb5St/LJy
	qizCTxpmogKcqXgc4qgyg5kwL7/GFbd7Wg9Sfz/edbbMf95Fu53cH/0YbkgFVex8
	frAXDRvylE9BIsDBMOw+PuMECMTbDDpQViJOE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=UVOLR4gQ6l3F8Ykc7ybKUL/+JAqLh3BV
	ajC7bBPuh8JUBYmptf03dQfMxUOki1+farat1N1oAUGeMwKz3O5zOdiOGAqvCzNr
	AmmIIY5zyuQDCAFQl+vpsfeanin0WbFMJw87YjK0ri1tkeng1is8VJj52a/sDCly
	5GGbtkyvNSQ=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 54E389EDF;
	Sun, 30 Sep 2012 04:00:27 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 936259EDE; Sun, 30 Sep 2012
 04:00:26 -0400 (EDT)
In-Reply-To: <1348899362-4057-9-git-send-email-mhagger@alum.mit.edu> (Michael
 Haggerty's message of "Sat, 29 Sep 2012 08:16:01 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: E503F32E-0AD4-11E2-8807-BB652E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/206679>

Michael Haggerty <mhagger@alum.mit.edu> writes:

> longest_ancestor_length() relies on a textual comparison of directory
> parts to find the part of path that overlaps with one of the paths in
> prefix_list.  But this doesn't work if any of the prefixes involves a
> symbolic link, because the directories will look different even though
> they might logically refer to the same directory.  So canonicalize the
> paths listed in prefix_list using real_path_if_valid() before trying
> to find matches.

I somehow feel that this is making the logic unnecessarily
convoluted by solving the problem at a wrong level.

If longest_ancestor_length() takes a single string and a list of
candidate string prefixes, conceptually it should be usable for any
hierarchy-looking string that uses slashes as hierarchy separator
(e.g. refs that may be stored in packed-refs that you cannot expect
lstat(2) or readlink(2) to give you any sensible results).

The real problem is that the list given from the environment may
contain a path that violates that "it suffices to take the longest
string-prefix taking slashes into account" assumption in such a
generic l-a-l implementation, no?  And this patch solves it by
making l-a-l _less_ generic and forcing it to be aware of the glitch
of its caller (you can either blame clueless user who lies when
setting the GIT_CEILING_DIRECTORIES by including paths contaminated
with symlinks, or blame the calling setup_git_directory_gently_1()
function that does not resolve the symbolic links before calling
this function).

As l-a-l is only used by the "stop at the ceiling" logic, isn't it a
far simpler solution to keep the function work at the string level,
and make the caller fix its input, i.e. the value taken from the
environment variable, before calling it?  That is, grab the value of
GIT_CEILING_DIRECTORIES, split it into a list at PATH_SEP (while
rejecting any non-absolute paths), normalize the elements of that
list by resolving symbolic links, and then pass the cwd[] and the
normalized string list to l-a-l?

The resulting callsite in setup_git_directory_gently_1() would pass
cwd[] and the ceiling_dirs (which now is a string list), all of
whose elements would happen to begin with "/" (or dos drive prefix
followed by the "root" symbol), but l-a-l can be written in such a
way that it does not even require that all the input has to begin at
root, which would later make it usable with things that are not
paths (references, for example, all of which begin with "refs/" and
not "/refs/").

Hrm?
