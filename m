From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 5/8] teach remote-testgit to import non-HEAD refs
Date: Wed, 08 Jun 2011 16:21:21 -0700
Message-ID: <7vipsf29la.fsf@alter.siamese.dyndns.org>
References: <20110607171838.GA21685@sigill.intra.peff.net>
 <20110607172052.GD22111@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Sverre Rabbelier <srabbelier@gmail.com>,
	Dmitry Ivankov <divanorama@gmail.com>, git@vger.kernel.org,
	Jonathan Nieder <jrnieder@gmail.com>,
	Ramkumar Ramachandra <artagnon@gmail.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Jun 09 01:21:43 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QUS4F-0004Vt-0d
	for gcvg-git-2@lo.gmane.org; Thu, 09 Jun 2011 01:21:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755487Ab1FHXVi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 8 Jun 2011 19:21:38 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:47066 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754347Ab1FHXVh (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 8 Jun 2011 19:21:37 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 5F5466E68;
	Wed,  8 Jun 2011 19:23:46 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Klbr3YYjdXlRuoLnJ9gtTsjhjFo=; b=U6mdtr
	aWvOJFfFNHa5trdHb2lB/HSvo3UtSB1wxFDo0VO43s2G7rNMJCRrHNVyopqUUSz8
	x1WIYubtwG1nYDIBGcnnmUKOumFka11GnH66j/slub40Q8ORSasr+/0Fv1StiplB
	9gkbi1q/JI+9T/RXrXqIf5eewExCcvMa5y5go=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=xueT8H2xNK6PJa622yC0eObbl9Pr2Nl6
	Ojxd0sFCt44WBfO0wIKETbZOOUxX/1U0b+II5NZ7b57DqF7l8VIlKYaxyR63Wqc6
	pjVT/TMSa7iWRrv7BEJa4uEd4WaNTUXm0KC+fea6Ab/35ezHPGbUxpu5LqT3LHvB
	Mpg+Z3Xbuhw=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id F3C3A6E67;
	Wed,  8 Jun 2011 19:23:39 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 1D5076E66; Wed,  8 Jun 2011
 19:23:31 -0400 (EDT)
In-Reply-To: <20110607172052.GD22111@sigill.intra.peff.net> (Jeff King's
 message of "Tue, 7 Jun 2011 13:20:52 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 57B46F12-9226-11E0-97AC-C8CFB7AE1C3C-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/175473>

Jeff King <peff@peff.net> writes:

> diff --git a/git_remote_helpers/git/exporter.py b/git_remote_helpers/git/exporter.py
> index f40f9d6..1855c6a 100644
> --- a/git_remote_helpers/git/exporter.py
> +++ b/git_remote_helpers/git/exporter.py
> @@ -15,7 +15,7 @@ class GitExporter(object):
>  
>          self.repo = repo
>  
> -    def export_repo(self, base):
> +    def export_repo(self, base, refs = ["HEAD"]):

This seems like an accident waiting to happen, even though it is Ok with
the current code (because this method does not modify refs in any way), to
specify a mutable object as the default value for an optional parameter.

> @@ -38,6 +38,7 @@ class GitExporter(object):
>          sys.stdout.flush()
>  
>          args = ["git", "--git-dir=" + self.repo.gitpath, "fast-export", "--export-marks=" + path]
> +	args.extend(refs)
>  
>          if os.path.exists(path):
>              args.append("--import-marks=" + path)

Hmm, am I looking at the right version of this file?

I see args.append("HEAD") after this --import-marks in the existing code,
which this patch does not remove.

An existing script that does not pass the new argument would end up
feeding HEAD twice, and if a new script does pass the new argument that
does not have "HEAD", it would still feed HEAD, to the underlying
fast-export.

I suspect that duplicated HEAD would not hurt for existing callers, but I
am not sure feeding HEAD unconditionally is a right thing to do.
