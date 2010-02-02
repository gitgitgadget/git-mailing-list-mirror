From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/2] gitweb: Add an option to force version match
Date: Tue, 02 Feb 2010 14:59:17 -0800
Message-ID: <7vvdef1by2.fsf@alter.siamese.dyndns.org>
References: <1265147814-13284-1-git-send-email-warthog9@eaglescrag.net>
 <1265147814-13284-2-git-send-email-warthog9@eaglescrag.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: "John 'Warthog9' Hawley" <warthog9@eaglescrag.net>
X-From: git-owner@vger.kernel.org Tue Feb 02 23:59:33 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NcRiV-0005oG-SN
	for gcvg-git-2@lo.gmane.org; Tue, 02 Feb 2010 23:59:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756996Ab0BBW70 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Feb 2010 17:59:26 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:38553 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756896Ab0BBW7Z (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Feb 2010 17:59:25 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 777EC9663B;
	Tue,  2 Feb 2010 17:59:24 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=p5q+RPI8xOCQEhxR+yINENXz4tI=; b=fjn5Nv
	1Jc5RNymtK1+kP+CiYFm8I+XEMo9WD3mUo/r1rRnKUJOYqVXf7tsHUXCC1jCesXs
	fwRMbc8bhpcZ23QjLgO9H6sjukLBKcFPeoLVQh9ER0/psDK/PAG7mxcL6xEDDEST
	1r+aLfwfm/DfenmAeYlo31/UhXMTWXADnJdaY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=AGGpTOK39TmMXPpUQBwww1pimlt2IkUU
	OJrS7qcLic4pbINx5exdRH/98Nha+31svBnCjosMUp2Ig4U/rp5/MAnOVbxrJ59B
	3zY0rVOjTGvGwHJTygEdNvxQjSPsOdUa4fKY4GcGzsD6ndsrnnlH1bD1ndSfLEI3
	tZ4TeQNlDO4=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 5284A9663A;
	Tue,  2 Feb 2010 17:59:22 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 7A51A96627; Tue,  2 Feb
 2010 17:59:19 -0500 (EST)
In-Reply-To: <1265147814-13284-2-git-send-email-warthog9@eaglescrag.net>
 (John Hawley's message of "Tue\,  2 Feb 2010 13\:56\:53 -0800")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 9A170262-104E-11DF-AB0A-6AF7ED7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/138777>

"John 'Warthog9' Hawley" <warthog9@eaglescrag.net> writes:

John, I'm sorry but I have to say this is somewhat incoherent.

> + * $git_versions_must_match
> +   If set to true value, gitweb fails with "500 Internal Server Error" error
> +   if the version of the gitweb doesn't match version of the git binary.
> +   Gitweb can usually run with a mismatched git install.   The default is 1
> +   (true).

I would understand that it if this were "Gitweb seldom runs correctly with
unmatched version of git, so this defaults to true".  If it can _usually_
run just fine, why should everybody need to flip this off?  This doesn't
make any sense to me.

> @@ -583,6 +586,33 @@ sub get_loadavg {
>  our $git_version = qx("$GIT" --version) =~ m/git version (.*)$/ ? $1 : "unknown";
>  $number_of_git_cmds++;
>  
> +# Throw an error if git versions does not match, if $git_versions_must_match is true.
> +if ($git_versions_must_match &&
> +    $git_version ne $version) {
> +	my $admin_contact =
> +		defined $ENV{'SERVER_ADMIN'} ? ", $ENV{'SERVER_ADMIN'}," : '';
> +	my $err_msg = <<EOT;
> +<h1 align="center">*** Warning ***</h1>
> +<p>
> +This version of gitweb was compiled for <b>@{[esc_html($version)]}</b>,
> +however git version <b>@{[esc_html($git_version)]}</b> was found on server.
> +Running an instance of gitweb that is not matched to the git binaries may
> +result in unexpected behavior of gitweb, and loss of functionality or
> +incorrect data on displayed pages.
> +</p>
> +<p>
> +Please update the git or gitweb installation so that their versions match, or
> +if you feel you are sure that you wish to proceed with running gitweb
> +with unmatched versions please contact the server administrator${admin_contact}
> +to configure gitweb to allow mismatched versions.  This can be done by
> +setting \$git_versions_must_match to @{[esc_html($git_versions_must_match)]}
> +(false value) in gitweb configuration file,
> +'@{[esc_path(-e $GITWEB_CONFIG ? $GITWEB_CONFIG : $GITWEB_CONFIG_SYSTEM)]}'.
> +</p>
> +EOT
> +	die_error(500, 'Internal server error', $err_msg);

Why, why, why?

This is not even a "*** Warning ***".  You are refusing to let them do
anything useful until they either flip the bit off or reinstall git and/or
gitweb.  It is a _fatal error_ message.

To whom are you giving this _warning_?  Please read the message yourself
again.

The message tells _you_ to consider using matching versions (as if _you_
have the choice and authority to do so), hints _you_ to decide if you are
Ok with running an unmatched combination (again, as if _you_ have the
authority to make that decision), and then instructs _you_ to contact the
server administrator (who presumably can flip the bit).

That doesn't make _any_ sense to me.  Hopefully anybody who installs or
upgrades gitweb/git will hit his gitweb installation at least once before
end users start hitting, so I would understand it if you wrote the above
message addressed to the server administrator.

If somebody updates his git without bothering to update gitweb, on the
other hand, the end user may see the message before the administrator
does.  If git and gitweb might be managed by different people at a
particular site (k.org?), I would understand that the administrator of the
gitweb side _might_ want to be told about it by the end user, and the
above might be an attempt to make that happen.

But even in that case, out of the three instructions, only the last one is
for the end user, and telling him to be certain the combinations do work
before bugging the gitweb administrator doesn't make much sense to me.

So I have to ask a basic question I asked (at least I tried to) last night
again.  Whom are you trying to help?

Even if it is to help a gitweb administrator who is not in charge of other
people in the administrator group who would install unmatching versions of
git without telling him, would this really be the best solution?  You'd be
the first to suffer from this when HPA or whoever installs a new version
of git at k.org.  There should be a better way to help communication
between the people in the administration group, without involving or
inconveniencing the end users like this patch seems to do.
