From: Henrik Austad <henrik@austad.us>
Subject: Re: git checkout does not warn about tags without corresponding commits
Date: Sat, 3 Jan 2009 13:37:00 +0100
Message-ID: <200901031337.00166.henrik@austad.us>
References: <200901021325.58049.henrik@austad.us> <200901031200.01883.henrik@austad.us> <7vr63k8vvf.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Daniel Barkalow <barkalow@iabervon.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Jan 03 13:38:42 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LJ5m4-0007eU-71
	for gcvg-git-2@gmane.org; Sat, 03 Jan 2009 13:38:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753218AbZACMhT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 3 Jan 2009 07:37:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757832AbZACMhR
	(ORCPT <rfc822;git-outgoing>); Sat, 3 Jan 2009 07:37:17 -0500
Received: from cassarossa.samfundet.no ([129.241.93.19]:53596 "EHLO
	cassarossa.samfundet.no" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753158AbZACMhP (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 3 Jan 2009 07:37:15 -0500
Received: from asterix.samfundet.no
	([2001:700:300:1800::f] helo=asterix.frsk.net ident=Debian-exim)
	by cassarossa.samfundet.no with esmtps (TLS-1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.63)
	(envelope-from <henrik@austad.us>)
	id 1LJ5kY-0002TB-Dq; Sat, 03 Jan 2009 13:37:06 +0100
Received: from vpn249.uninett.no ([158.38.64.249])
	by asterix.frsk.net with esmtpsa (TLS-1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.63)
	(envelope-from <henrik@austad.us>)
	id 1LJ5kY-0002k4-2P; Sat, 03 Jan 2009 13:37:06 +0100
User-Agent: KMail/1.9.10
In-Reply-To: <7vr63k8vvf.fsf@gitster.siamese.dyndns.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/104465>

On Saturday 03 January 2009 12:36:04 Junio C Hamano wrote:
> Henrik Austad <henrik@austad.us> writes:
> > On Friday 02 January 2009 22:44:50 Junio C Hamano wrote:
> >> Henrik Austad <henrik@austad.us> writes:
> >> > I recently tried to do a checkout of (what I thought was the first)
> >> > inux kernel in the linux git repo.
> >> >
> >> > git checkout -b 2.6.11 v2.6.11
> >>
> >> This should have barfed, and indeed I think it is a regression around
> >> v1.5.5.  v1.5.4 and older git definitely fails to check out a tree
> >> object like that.
> >
> > You're right, I bisected it down to commit
> > 782c2d65c24066a5d83453efb52763bc34c10f81
>
> I am not surprised.
>
> That one discarded an implementation of "git checkout" in Bourne shell,
> with a complete reimplementation in C.
>
> I haven't looked at the code very closely, but I think this should fix
> it.  Thorough reviewing (not just running the test suite) is much
> appreciated.
>
> -- >8 --
> Subject: git-checkout: do not allow switching to a tree-ish
>
> "git checkout -b newbranch $commit^{tree}" mistakenly created a new branch
> rooted at the current HEAD, because in that case, the two structure fields
> used to see if the command was invoked without any argument (hence it
> needs to default to checking out the HEAD), were populated incorrectly.
>
> Upon seeing a command line argument that we took as a rev, we should store
> that string in new.name, even if that does not name a commit.
>
> Signed-off-by: Junio C Hamano <gitster@pobox.com>
> ---
>  builtin-checkout.c               |    2 +-
>  t/t2011-checkout-invalid-head.sh |    4 ++++
>  2 files changed, 5 insertions(+), 1 deletions(-)
>
> diff --git c/builtin-checkout.c w/builtin-checkout.c
> index c2c0561..b5dd9c0 100644
> --- c/builtin-checkout.c
> +++ w/builtin-checkout.c
> @@ -681,8 +681,8 @@ int cmd_checkout(int argc, const char **argv, const
> char *prefix) argv++;
>  		argc--;
>
> +		new.name = arg;
>  		if ((new.commit = lookup_commit_reference_gently(rev, 1))) {
> -			new.name = arg;
>  			setup_branch_path(&new);
>  			if (resolve_ref(new.path, rev, 1, NULL))
>  				new.commit = lookup_commit_reference(rev);


this fixed my problem when i hacked this into master (git apply failed on the 
patch, so I did a manual patch. Moving that line did the trick

Acked-by/Signed-off-by Henrik Austad <henrik@austad.us>


> diff --git c/t/t2011-checkout-invalid-head.sh
> w/t/t2011-checkout-invalid-head.sh index 764bb0a..798790d 100755
> --- c/t/t2011-checkout-invalid-head.sh
> +++ w/t/t2011-checkout-invalid-head.sh
> @@ -15,4 +15,8 @@ test_expect_success 'checkout master from invalid HEAD' '
>  	git checkout master --
>  '
>
> +test_expect_success 'checkout should not start branch from a tree' '
> +	test_must_fail git checkout -b newbranch master^{tree}
> +'
> +
>  test_done
>
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html



-- 
 -> henrik
