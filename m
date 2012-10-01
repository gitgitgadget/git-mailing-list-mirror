From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [PATCH v2 8/9] longest_ancestor_length(): resolve symlinks before
 comparing paths
Date: Mon, 01 Oct 2012 06:51:28 +0200
Message-ID: <50692150.8080504@alum.mit.edu>
References: <1348899362-4057-1-git-send-email-mhagger@alum.mit.edu> <1348899362-4057-9-git-send-email-mhagger@alum.mit.edu> <7vd314gcti.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Jiang Xin <worldhello.net@gmail.com>,
	Lea Wiemann <lewiemann@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Oct 01 06:51:44 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TIXyo-0006aK-Nw
	for gcvg-git-2@plane.gmane.org; Mon, 01 Oct 2012 06:51:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750938Ab2JAEvd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 1 Oct 2012 00:51:33 -0400
Received: from ALUM-MAILSEC-SCANNER-4.MIT.EDU ([18.7.68.15]:57582 "EHLO
	alum-mailsec-scanner-4.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750738Ab2JAEvc (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 1 Oct 2012 00:51:32 -0400
X-AuditID: 1207440f-b7fde6d00000095c-30-50692153a533
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-4.mit.edu (Symantec Messaging Gateway) with SMTP id 18.87.02396.35129605; Mon,  1 Oct 2012 00:51:31 -0400 (EDT)
Received: from [192.168.69.140] (p57A25472.dip.t-dialin.net [87.162.84.114])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id q914pS7O004345
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Mon, 1 Oct 2012 00:51:30 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:15.0) Gecko/20120827 Thunderbird/15.0
In-Reply-To: <7vd314gcti.fsf@alter.siamese.dyndns.org>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrIKsWRmVeSWpSXmKPExsUixO6iqBusmBlgMHG/nEXXlW4mi4beK8wW
	R09ZWKx/d5XZgcVj56y77B4XLyl7fN4kF8AcxW2TlFhSFpyZnqdvl8CdsXjdRsaCJvWK7p1d
	7A2MW+W7GDk5JARMJJY/bWKDsMUkLtxbD2RzcQgJXGaUWLD+IAuEc5pJ4vrNz8wgVbwC2hJf
	p3WygtgsAqoSbyZ9ZgSx2QR0JRb1NDOB2KICIRIzLk+GqheUODnzCQuILSKgJjGx7RCYzSyQ
	KdHy5R3YZmGBBIk5/f/AbCGBpYwS1zeD9XIKmEkceH0dql5H4l3fA2YIW15i+9s5zBMYBWYh
	WTELSdksJGULGJlXMcol5pTm6uYmZuYUpybrFicn5uWlFuma6OVmluilppRuYoQEMf8Oxq71
	MocYBTgYlXh4f13NCBBiTSwrrsw9xCjJwaQkysshnxkgxJeUn1KZkVicEV9UmpNafIhRgoNZ
	SYSXcwZQOW9KYmVValE+TEqag0VJnFd9ibqfkEB6YklqdmpqQWoRTFaGg0NJgvcAyFDBotT0
	1Iq0zJwShDQTByfIcC4pkeLUvJTUosTSkox4UKzGFwOjFSTFA7RXQgGonbe4IDEXKArReopR
	l2Pt3QUPGIVY8vLzUqXEeYVAigRAijJK8+BWwFLWK0ZxoI+FeT+DXMIDTHdwk14BLWECWlK1
	Kg1kSUkiQkqqgXGp1zWPA5lvrLg3fLb8HnYuena96tvtgcKT3z17/+q0jqbLkaLjLc+ef074
	vHtR9+PypEdT2y9cd3Xca8ERsdDWfud538VfX7CpmUaL2/etCpbJsZN6+C9QxPTh 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/206713>

On 09/30/2012 10:00 AM, Junio C Hamano wrote:
> Michael Haggerty <mhagger@alum.mit.edu> writes:
> 
>> longest_ancestor_length() relies on a textual comparison of directory
>> parts to find the part of path that overlaps with one of the paths in
>> prefix_list.  But this doesn't work if any of the prefixes involves a
>> symbolic link, because the directories will look different even though
>> they might logically refer to the same directory.  So canonicalize the
>> paths listed in prefix_list using real_path_if_valid() before trying
>> to find matches.
> 
> I somehow feel that this is making the logic unnecessarily
> convoluted by solving the problem at a wrong level.
> 
> If longest_ancestor_length() takes a single string and a list of
> candidate string prefixes, conceptually it should be usable for any
> hierarchy-looking string that uses slashes as hierarchy separator
> (e.g. refs that may be stored in packed-refs that you cannot expect
> lstat(2) or readlink(2) to give you any sensible results).
> 
> The real problem is that the list given from the environment may
> contain a path that violates that "it suffices to take the longest
> string-prefix taking slashes into account" assumption in such a
> generic l-a-l implementation, no?  And this patch solves it by
> making l-a-l _less_ generic and forcing it to be aware of the glitch
> of its caller (you can either blame clueless user who lies when
> setting the GIT_CEILING_DIRECTORIES by including paths contaminated
> with symlinks, or blame the calling setup_git_directory_gently_1()
> function that does not resolve the symbolic links before calling
> this function).
> 
> As l-a-l is only used by the "stop at the ceiling" logic, isn't it a
> far simpler solution to keep the function work at the string level,
> and make the caller fix its input, i.e. the value taken from the
> environment variable, before calling it?  That is, grab the value of
> GIT_CEILING_DIRECTORIES, split it into a list at PATH_SEP (while
> rejecting any non-absolute paths), normalize the elements of that
> list by resolving symbolic links, and then pass the cwd[] and the
> normalized string list to l-a-l?
> 
> The resulting callsite in setup_git_directory_gently_1() would pass
> cwd[] and the ceiling_dirs (which now is a string list), all of
> whose elements would happen to begin with "/" (or dos drive prefix
> followed by the "root" symbol), but l-a-l can be written in such a
> way that it does not even require that all the input has to begin at
> root, which would later make it usable with things that are not
> paths (references, for example, all of which begin with "refs/" and
> not "/refs/").

I agree that longest_ancestor_length() is not very generic or
interesting anymore.  Nearly all of its "added value" comes from the
normalize_path_callback() helper function.  One possibility would be to
inline it at the one place it is called.

The function string_list_longest_prefix() was my attempt to isolate the
kernel of generic functionality from longest_ancestor_path().  It is
*almost* the function that you are proposing, with the exception that it
does not ensure that the prefix match ends at a "/" boundary.  So
another alternative could be to change this function to respect "/"
boundaries.  (After the change, the function might not belong in the
string-list API anymore.)

However, the semantics of a function that matches prefixes at "/"
boundaries is not entirely obvious.  Suppose we would implement the test
via a function like path_prefixcmp(path, prefix).  I can think of a few
policy questions that would have to be answered:

* Is a trailing slash on the prefix argument required, optional, or
prohibited?  What if the prefix is "/" or "//" or "c:/"?

* Is a trailing slash on the path argument optional/prohibited?  Are "/"
or "//" allowed as path arguments?

* Is a path its own prefix?

    path_prefixcmp("a/b", "a/b") -> true or false?

(For the implementation of longest_ancestor_path(), we would prefer this
to return "false".)  Or does the answer depend on whether the prefix has
a trailing slash?

    path_prefixcmp("a/b", "a/b") -> true?
    path_prefixcmp("a/b", "a/b/") -> false?

Part of the reason that I implemented string_list_longest_prefix()
instead of the function that you suggest is that the behavior of the
former is far more obvious.

I think I would advocate that the prefix has to match the front of the
path exactly (including any trailing slashes) and either

    strlen(prefix) == 0
    or the prefix ended with a '/'
    or the prefix and path are identical
    or the character in path following the matching part is a '/'

This would allow the "is path its own prefix" policy to be decided by
the caller by either including or omitting a trailing slash on the
prefix argument.

Michael

-- 
Michael Haggerty
mhagger@alum.mit.edu
http://softwareswirl.blogspot.com/
