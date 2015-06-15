From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v4] receive-pack: Create a HEAD ref for ref namespace
Date: Mon, 15 Jun 2015 13:48:02 -0700
Message-ID: <xmqqlhfk7l6l.fsf@gitster.dls.corp.google.com>
References: <1433193883-11577-1-git-send-email-johannes@kyriasis.com>
	<1433526142-2413-1-git-send-email-johannes@kyriasis.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Johannes =?utf-8?Q?L=C3=B6thberg?= <johannes@kyriasis.com>
X-From: git-owner@vger.kernel.org Mon Jun 15 22:48:12 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z4bIh-0004tE-4a
	for gcvg-git-2@plane.gmane.org; Mon, 15 Jun 2015 22:48:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752256AbbFOUsH convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 15 Jun 2015 16:48:07 -0400
Received: from mail-ie0-f175.google.com ([209.85.223.175]:34635 "EHLO
	mail-ie0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751392AbbFOUsF (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Jun 2015 16:48:05 -0400
Received: by iebmu5 with SMTP id mu5so190120ieb.1
        for <git@vger.kernel.org>; Mon, 15 Jun 2015 13:48:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type:content-transfer-encoding;
        bh=vd00iJzc2M8YpMpuRvii7+1S9BeVKT6AiGKt0rIw5c4=;
        b=tC/CA1h4AoQ5WFk2uGzGURRs1tM6U+o0qgnHH5zYAJWGBxi9arnE6JSUcyRL1GCUuX
         FORn8rETIhAGPEds3aIU7XJlLLr8evPAGU8o3/vuhGWLGRC3FKpy62A/lj1i13W0MvP+
         bEUueUZB63QVy6FNjn0r5Q6itZIDv/uKOlEmggvOQvxjFz0jeeOR12f0udPaCXY4nNzy
         GRMlur5MO5GtcL1hmIfmKaC53G7b1s0zolaLM7XaYdL1GMNozFu40yDWYVnfcIHxbQ77
         ODmko1lH54Z3Rjnm1vH0SUI1WBa+unRpH1PhncXKmsyy1FWwXyIvNDBcYt6MYMvJUWkf
         pfGQ==
X-Received: by 10.50.13.98 with SMTP id g2mr23546310igc.16.1434401284391;
        Mon, 15 Jun 2015 13:48:04 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:16f:c4ab:c37f:75f8])
        by mx.google.com with ESMTPSA id j4sm8365207igo.0.2015.06.15.13.48.03
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Mon, 15 Jun 2015 13:48:03 -0700 (PDT)
In-Reply-To: <1433526142-2413-1-git-send-email-johannes@kyriasis.com>
	("Johannes =?utf-8?Q?L=C3=B6thberg=22's?= message of "Fri, 5 Jun 2015
 19:42:22 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/271724>

Johannes L=C3=B6thberg <johannes@kyriasis.com> writes:

> diff --git a/builtin/receive-pack.c b/builtin/receive-pack.c
> index d2ec52b..0c18c92 100644
> --- a/builtin/receive-pack.c
> +++ b/builtin/receive-pack.c
> @@ -864,7 +864,9 @@ static const char *update(struct command *cmd, st=
ruct shallow_info *si)
>  {
>  	const char *name =3D cmd->ref_name;
>  	struct strbuf namespaced_name_buf =3D STRBUF_INIT;
> -	const char *namespaced_name, *ret;
> +	struct strbuf namespaced_head_buf =3D STRBUF_INIT;
> +	const char *namespaced_name, *ret, *namespace;
> +	const char *namespaced_head_path;
>  	unsigned char *old_sha1 =3D cmd->old_sha1;
>  	unsigned char *new_sha1 =3D cmd->new_sha1;
> =20
> @@ -981,6 +983,14 @@ static const char *update(struct command *cmd, s=
truct shallow_info *si)
>  		return NULL; /* good */
>  	}
>  	else {
> +		namespace =3D get_git_namespace();
> +		if (strcmp(namespace, "refs/namespaces/")) {
> +			strbuf_addf(&namespaced_head_buf, "%s%s", namespace, "HEAD");
> +			namespaced_head_path =3D strbuf_detach(&namespaced_head_buf, NULL=
);
> +
> +			create_symref(namespaced_head_path, namespaced_name, NULL);

In a normal environment without any namespace, get_git_namespace()
will return an empty string, which is not "refs/namespaces/", so we
create a symref HEAD (that is .git/HEAD) that points at whatever
name the command is about.  And this is done every time any ref is
updated, flipping the HEAD to point at whatever was pushed the last,
isn't it?

Why is this a good change?  I am puzzled...

> +		}
> +
>  		struct strbuf err =3D STRBUF_INIT;

This adds decl-after-stmt.

Going back to the proposed log message...

> Each ref namespace have their own separate branches, tags, and HEAD, =
so
> when pushing to a namespace we need to make sure that there exists a
> HEAD ref for the namespace, otherwise you will not be able to check o=
ut
> the repo after cloning from a namespace

What this paragraph describes is entirely correct, I think.  But I
do not think receive-pack is the "we" in that paragraph.

When setting up a "namespace" a and b, shouldn't you be doing
essentially

	r=3Drefs/namespaces/
	for ns in a b
        do
		git symbolic-ref $r$ns/HEAD $r$ns/refs/heads/master
	done

or something, which is an equivalent to what "git init" does to a
normal repository?
