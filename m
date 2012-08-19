From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] test: some testcases failed if cwd is on a symlink
Date: Sun, 19 Aug 2012 09:43:37 -0700
Message-ID: <7vharyq1c6.fsf@alter.siamese.dyndns.org>
References: <001c60538df409d94618e80cc3faaae586ccf053.1343116581.git.worldhello.net@gmail.com> <7vboj5gqqo.fsf@alter.siamese.dyndns.org> <loom.20120818T162226-852@post.gmane.org> <7vfw7krl8r.fsf@alter.siamese.dyndns.org> <5030F0BF.2090500@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Sun Aug 19 18:43:47 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T38bK-0005jP-20
	for gcvg-git-2@plane.gmane.org; Sun, 19 Aug 2012 18:43:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754109Ab2HSQnl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 19 Aug 2012 12:43:41 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:39323 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751943Ab2HSQnj (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 19 Aug 2012 12:43:39 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 6FAD259A7;
	Sun, 19 Aug 2012 12:43:39 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=oQukdzGX/X8sj9yeCrxziFntOS0=; b=blNNfs
	klpNHwBQ7HqF443XlcA/eQWhEUtWTqSG7r4V4QHu4AMjxi7Wt9E7LwA0Er0KJLGR
	RdL3q3Hq8J8iJDAROmZt+z1xG3ZWfC9fy6/5qg5cbTrwB0a+ngAbJwaglGbuqL+g
	7YbRhob8lGn4czG3PoymVjPG2Un4aL9lGKTO8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=bpYZgniZ0d5UpOVDQ8pAHZrAPxw9Ropc
	vSBwTi95nl8I/ZIzg+enLPEKODICgLSLnMB2FPPSgXtk4DQh3gyt+sWDgAQHPKo3
	WCI8nok/ZF5YTPh8G0KnrvCOk6oww9MCTajJgT89zZf1ohuRjBki51qfW46hz6y8
	rzE6ERwEzT0=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 5C19659A6;
	Sun, 19 Aug 2012 12:43:39 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id A807959A5; Sun, 19 Aug 2012
 12:43:38 -0400 (EDT)
In-Reply-To: <5030F0BF.2090500@alum.mit.edu> (Michael Haggerty's message of
 "Sun, 19 Aug 2012 15:57:19 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 06CE4F46-EA1D-11E1-825B-01B42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/203723>

Michael Haggerty <mhagger@alum.mit.edu> writes:

> I just verified that the combination of your two suggestions (i.e., the
> patch below) fixes the problem for me.

Good to know.

The only remaining two worries from me are if everybody has working
pwd at that early point in the script (I think MINGW replaces pwd
with its own), and if the latter one should really be "/bin/pwd"
everywhere.  Saying "Give the true path to --root when you run it"
can sidestep the latter issue ;-)

> Nevertheless, I'm not sure that this is the best solution.  The test
> failures that occur without this change suggest to me that
> GIT_CEILING_DIRECTORIES is implemented in a fragile way.

Hrmph.  How would you improve it?  chdir() around twice and compare?

> diff --git a/t/test-lib.sh b/t/test-lib.sh
> index bb4f886..c7f320f 100644
> --- a/t/test-lib.sh
> +++ b/t/test-lib.sh
> @@ -15,6 +15,8 @@
>  # You should have received a copy of the GNU General Public License
>  # along with this program.  If not, see http://www.gnu.org/licenses/ .
>
> +cd "$(pwd -P)"
> +
>  # if --tee was passed, write the output not only to the terminal, but
>  # additionally to the file test-results/$BASENAME.out, too.
>  case "$GIT_TEST_TEE_STARTED, $* " in
> @@ -166,6 +168,7 @@ do
>                 shift ;; # was handled already
>         --root=*)
>                 root=$(expr "z$1" : 'z[^=]*=\(.*\)')
> +               root=$(cd "$root" && /bin/pwd)
>                 shift ;;
>         *)
>                 echo "error: unknown test option '$1'" >&2; exit 1 ;;
