From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: regression in git-gui since 2c5c66b... Merge branch 'jp/get-ref-dir-unsorted
Date: Mon, 17 Oct 2011 15:35:56 +0200
Message-ID: <4E9C2F3C.7080405@alum.mit.edu>
References: <4E9B1E32.7030101@gmail.com> <7vfwispi8u.fsf@alter.siamese.dyndns.org> <4E9B8719.1090203@gmail.com> <4E9BA39B.709@alum.mit.edu> <4E9BFE66.5070906@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Mark Levedahl <mlevedahl@gmail.com>
X-From: git-owner@vger.kernel.org Mon Oct 17 15:36:06 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RFnMM-0006xX-2C
	for gcvg-git-2@lo.gmane.org; Mon, 17 Oct 2011 15:36:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754792Ab1JQNgA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 Oct 2011 09:36:00 -0400
Received: from einhorn.in-berlin.de ([192.109.42.8]:48729 "EHLO
	einhorn.in-berlin.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753193Ab1JQNf7 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Oct 2011 09:35:59 -0400
X-Envelope-From: mhagger@alum.mit.edu
Received: from [192.168.100.152] (ssh.berlin.jpk.com [212.222.128.135])
	(authenticated bits=0)
	by einhorn.in-berlin.de (8.13.6/8.13.6/Debian-1) with ESMTP id p9HDZudH021487
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Mon, 17 Oct 2011 15:35:56 +0200
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.9.2.23) Gecko/20110921 Lightning/1.0b2 Thunderbird/3.1.15
In-Reply-To: <4E9BFE66.5070906@gmail.com>
X-Scanned-By: MIMEDefang_at_IN-Berlin_e.V. on 192.109.42.8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/183792>

On 10/17/2011 12:07 PM, Mark Levedahl wrote:
> Your modification of my script does not show the error for me, unless I
> have *installed* a version of git with the failure: I suspect git-gui
> invokes installed components, and not what is in the build directory, so
> having a good version of git installed with the bad version in the build
> directory does not show the error. And yes, I am quite sure that all of
> the git commands I am running are from the one version.

Yes, you seem to be right.  Even if I set PATH to list my git build
directory before the directory where it is installed, "git-gui"
sometimes invokes git-rev-parse from the libexec path of the installed
version.

When I install the compiled git, then I see the behavior that you describe.

The invocation that behaves differently is

    git ls-files --others -z --exclude-standard

(run in the "super" directory).  It doesn't seem to matter which version
of git is used to create the test repository.  Under 2c5c66b, it outputs
"sub/a", whereas under either of the merge commit's ancestors, the
command outputs "sub/".

    git ls-files --others

I believe that the problem originates in code in
resolve_gitlink_packed_ref() that was invented during the merge 2c5c66b:

static int resolve_gitlink_packed_ref(char *name, int pathlen, const
char *refname, unsigned char *result)
{
	int retval = -1;
	struct ref_entry *ref;
	struct ref_array *array = get_packed_refs(name);

	ref = search_ref_array(array, refname);
	if (ref != NULL) {
		memcpy(result, ref->sha1, 20);
		retval = 0;
	}
	return retval;
}

The problem is that the parameter "name" is not NUL-terminated.  The old
code turned it into a (NUL-terminated) filename via

    strcpy(name + pathlen, "packed-refs");

but the new code passes it (unterminated) to get_packed_refs()

Coincidentally, the old (correct) behavior is restored by a patch that I
submitted earlier today:

    "Pass a (ref_cache *) to the resolve_gitlink_*() helper functions".

Michael

-- 
Michael Haggerty
mhagger@alum.mit.edu
http://softwareswirl.blogspot.com/
