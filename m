From: Dave Olszewski <cxreg@pobox.com>
Subject: Re: Re: [git] Re: "git stash list" shows HEAD reflog
Date: Sat, 13 Mar 2010 13:21:15 -0800 (PST)
Message-ID: <alpine.DEB.2.00.1003131312540.796@narbuckle.genericorp.net>
References: <op.u9gl97fstuzx1w@cybershadow.mshome.net> <4B9BCD6E.4090902@lsrfire.ath.cx> <alpine.DEB.2.00.1003130939240.796@narbuckle.genericorp.net> <4B9BF171.2000102@lsrfire.ath.cx>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; format=flowed; charset=US-ASCII
Cc: Dave Olszewski <cxreg@pobox.com>,
	Vladimir Panteleev <vladimir@thecybershadow.net>,
	git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: =?ISO-8859-15?Q?Ren=E9_Scharfe?= <rene.scharfe@lsrfire.ath.cx>
X-From: git-owner@vger.kernel.org Sat Mar 13 22:21:30 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NqYlz-000211-Vt
	for gcvg-git-2@lo.gmane.org; Sat, 13 Mar 2010 22:21:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S935956Ab0CMVVW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 13 Mar 2010 16:21:22 -0500
Received: from 62.f9.1243.static.theplanet.com ([67.18.249.98]:56607 "EHLO
	62.f9.1243.static.theplanet.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S935900Ab0CMVVV (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 13 Mar 2010 16:21:21 -0500
X-Envelope-From: cxreg@pobox.com
Received: from localhost (count@narbuckle [127.0.0.1])
	(authenticated bits=0)
	by 62.f9.1243.static.theplanet.com (8.13.8/8.13.8/Debian-3) with ESMTP id o2DLLFN4017821
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Sat, 13 Mar 2010 15:21:16 -0600
X-X-Sender: count@narbuckle.genericorp.net
In-Reply-To: <4B9BF171.2000102@lsrfire.ath.cx>
User-Agent: Alpine 2.00 (DEB 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/142107>

On Sat, 13 Mar 2010, Ren? Scharfe wrote:

> Am 13.03.2010 18:41, schrieb Dave Olszewski:
>> On Sat, 13 Mar 2010, Ren? Scharfe wrote:
>>
>>> Am 12.03.2010 15:52, schrieb Vladimir Panteleev:
>>
>>>> That doesn't explain why git displayed the HEAD reflog, though. That
>>>> seems to happen thanks to the check (revs->def && !revs->pending.nr) in
>>>> setup_revisions ("HEAD" is the default, as specified in the caller
>>>> cmd_log_init). It looks like (ideally) git shouldn't rely on whether
>>>> revs->pending is empty to decide whether to use the default, but rather
>>>> if a ref was specified by the user or not.
>>>
>>> We could add some kind of check there, but with the patch applied I can't
>>> trigger this second issue any more.  It would be nice to have a test
>>> script
>>> along with such a sanity check.  Any idea how to cause this error,
>>> perhaps
>>> with another type of invalid reflog file?
>>
>> I actually noticed this last week.  You can reproduce it by doing "git
>> reflog" on a branch which has been idle for longer than the expiration.
>> Any 0-byte files in logs/refs/heads would give me this same behavior.
>>
>>     Dave
>
> Perhaps something like this?

Maybe, although I'm not sure if dying here is the right behavior.  Is an
empty reflog really an error?  I was testing a patch along the lines of
what Vladimir proposed, which was simply to not set the default rev if a
valid user-specified argument was found, whether or not it contains
commits.

> ---
> revision.c             |    4 ++++
> t/t1411-reflog-show.sh |   13 +++++++++++++
> 2 files changed, 17 insertions(+), 0 deletions(-)
>
> diff --git a/revision.c b/revision.c
> index 29721ec..6991475 100644
> --- a/revision.c
> +++ b/revision.c
> @@ -896,6 +896,7 @@ int handle_revision_arg(const char *arg, struct rev_info *revs,
> 	struct object *object;
> 	unsigned char sha1[20];
> 	int local_flags;
> +	int empty_after, empty_before = !revs->pending.nr;
>
> 	dotdot = strstr(arg, "..");
> 	if (dotdot) {
> @@ -971,6 +972,9 @@ int handle_revision_arg(const char *arg, struct rev_info *revs,
> 		verify_non_filename(revs->prefix, arg);
> 	object = get_reference(revs, arg, sha1, flags ^ local_flags);
> 	add_pending_object_with_mode(revs, object, arg, mode);
> +	empty_after = !revs->pending.nr;
> +	if (empty_before && empty_after)
> +		die("bad revision '%s' (empty reflog?)", arg);
> 	return 0;
> }
>
> diff --git a/t/t1411-reflog-show.sh b/t/t1411-reflog-show.sh
> index c18ed8e..3f48c2d 100755
> --- a/t/t1411-reflog-show.sh
> +++ b/t/t1411-reflog-show.sh
> @@ -64,4 +64,17 @@ test_expect_success 'using --date= shows reflog date (oneline)' '
> 	test_cmp expect actual
> '
>
> +: >expected.out
> +cat >expected.err <<'EOF'
> +fatal: bad revision 'empty' (empty reflog?)
> +EOF
> +test_expect_success 'empty reflog file' '
> +	git branch empty &&
> +	: >.git/logs/refs/heads/empty &&
> +
> +	test_must_fail git log -g empty >actual.out 2>actual.err &&
> +	test_cmp expected.out actual.out &&
> +	test_cmp expected.err actual.err
> +'
> +
> test_done
> -- 
> 1.7.0.2
>
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
>
>
