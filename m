From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 2/3] branch: suggest how to undo a --set-upstream when
 given one branch
Date: Tue, 10 Jul 2012 14:24:08 -0500
Message-ID: <20120710192408.GF8439@burratino>
References: <1341939181-8962-1-git-send-email-cmn@elego.de>
 <1341939181-8962-3-git-send-email-cmn@elego.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, gitster@pobox.com,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
To: Carlos =?utf-8?Q?Mart=C3=ADn?= Nieto <cmn@elego.de>
X-From: git-owner@vger.kernel.org Tue Jul 10 21:24:21 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Sog2l-0002XI-6X
	for gcvg-git-2@plane.gmane.org; Tue, 10 Jul 2012 21:24:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751991Ab2GJTYN convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 10 Jul 2012 15:24:13 -0400
Received: from mail-yw0-f46.google.com ([209.85.213.46]:48243 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751876Ab2GJTYN convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 10 Jul 2012 15:24:13 -0400
Received: by yhmm54 with SMTP id m54so393421yhm.19
        for <git@vger.kernel.org>; Tue, 10 Jul 2012 12:24:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=b5lyDyl8wU+bjLnZmBV7BjxiZXstS0wTV9CUst2Pyhc=;
        b=OrLJCkKHFB9bjIsu2UwUnUc7HlW/3mrzCMWg0GN4ze0Y0YJJ7FD7n2SJx2UrFtlZpN
         mYz0vSNv7fivDVYyUdCoG2Vxs8jWIiE4HnMHTDzFuiN8K2/UYyzIGqR11Aor3HaLx8dd
         XF7sJB1wstFYMOLwyHEZYC/G+GI1/qEOikVtSZucwLVCdXEcvFNqc7lbnrZKXkz/ho23
         GdCJbdb1GGviMqWniBPkS2gVUvb6P2PUkdLzDW4MRDE9a8bZU+e/q2IlSb+N7Y9yPe8N
         Q3brB0Sav2nAkb/FzFpk/Yv3/u3eI3TnOCQHWLvlg3zrHwWEgf7A0fYc+ee1xz03ntkh
         yu9Q==
Received: by 10.50.42.165 with SMTP id p5mr12474311igl.68.1341948252451;
        Tue, 10 Jul 2012 12:24:12 -0700 (PDT)
Received: from burratino (cl-1372.chi-02.us.sixxs.net. [2001:4978:f:55b::2])
        by mx.google.com with ESMTPS id nh8sm12599989igc.1.2012.07.10.12.24.11
        (version=SSLv3 cipher=OTHER);
        Tue, 10 Jul 2012 12:24:11 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1341939181-8962-3-git-send-email-cmn@elego.de>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/201271>

Hi,

Quick nitpicks.

Carlos Mart=C3=ADn Nieto wrote:

> --- a/builtin/branch.c
> +++ b/builtin/branch.c
> @@ -864,10 +864,32 @@ int cmd_branch(int argc, const char **argv, con=
st char *prefix)
>  		   info and making sure new_upstream is correct */
>  		create_branch(head, branch->name, new_upstream, 0, 0, 0, quiet, BR=
ANCH_TRACK_OVERRIDE);
>  	} else if (argc > 0 && argc <=3D 2) {
> +		struct branch *branch =3D branch_get(argv[0]);
> +		const char *old_upstream =3D NULL;
> +		int branch_existed =3D 0;
> +
>  		if (kinds !=3D REF_LOCAL_BRANCH)
>  			die(_("-a and -r options to 'git branch' do not make sense with a=
 branch name"));
> +
> +		/* Save what argv[0] was pointing to so we can give
> +		   the --set-upstream-to hint */
> +		if (branch_has_merge_config(branch))
> +		  old_upstream =3D shorten_unambiguous_ref(branch->merge[0]->dst, =
0);

Whitespace is odd here.  Maybe this case could be factored out as a
new function to make room on the right margin and make cmd_branch()
easier to read straight through.

> +
> +		branch_existed =3D ref_exists(branch->refname);
>  		create_branch(head, argv[0], (argc =3D=3D 2) ? argv[1] : head,
>  			      force_create, reflog, 0, quiet, track);
> +
> +		if (argc =3D=3D 1) {
> +			printf("If you wanted to make '%s' track '%s', do this:\n", head,=
 argv[0]);
> +			if (branch_existed)
> +				printf(" $ git branch --set-upstream '%s' '%s'\n", argv[0], old_=
upstream);
> +			else
> +				printf(" $ git branch -d '%s'\n", argv[0]);
> +
> +			printf(" $ git branch --set-upstream-to '%s'\n", argv[0]);

Message should go on stderr and be guarded with an advice option (see
advice.c).

Like this:

	const char *arg;

	...
	if (argc !=3D 1 || !advice_old_fashioned_set_upstream)
		return 0; /* ok. */

	arg =3D argv[0];
	advise("If you wanted to make '%s' track '%s', do this:",
							head, arg);
	if (branch_existed)
		advise(" $ git branch --set-upstream-to=3D'%s' '%s'",
			old_upstream, arg);
	else
		advise(" $ git branch -d '%s'", arg);
	advise(" $ git branch --set-upstream-to=3D'%s'", arg);

If an argument contains single-quotes, the quoting will be wrong, but
that's probably not worth worrying about.

Hope that helps,
Jonathan
