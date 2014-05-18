From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH] request-pull: resurrect for-linus -> tags/for-linus DWIM
Date: Sun, 18 May 2014 11:33:05 +0300
Message-ID: <20140518083305.GB28462@redhat.com>
References: <1400263070-15312-1-git-send-email-gitster@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun May 18 10:34:32 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WlwYB-0001jU-PS
	for gcvg-git-2@plane.gmane.org; Sun, 18 May 2014 10:34:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752123AbaERIeW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 18 May 2014 04:34:22 -0400
Received: from mx1.redhat.com ([209.132.183.28]:60065 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751654AbaERIeO (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 18 May 2014 04:34:14 -0400
Received: from int-mx01.intmail.prod.int.phx2.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id s4I8YCKU024646
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK);
	Sun, 18 May 2014 04:34:12 -0400
Received: from redhat.com (ovpn-116-27.ams2.redhat.com [10.36.116.27])
	by int-mx01.intmail.prod.int.phx2.redhat.com (8.13.8/8.13.8) with SMTP id s4I8YA18002715;
	Sun, 18 May 2014 04:34:11 -0400
Content-Disposition: inline
In-Reply-To: <1400263070-15312-1-git-send-email-gitster@pobox.com>
X-Scanned-By: MIMEDefang 2.67 on 10.5.11.11
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/249500>

On Fri, May 16, 2014 at 10:57:50AM -0700, Junio C Hamano wrote:
> Older versions of Git before v1.7.10 did not DWIM
> 
>     $ git pull $URL for-linus
> 
> to the tag "tags/for-linus" and the users were required to say
> 
>     $ git pull $URL tags/for-linus
> 
> instead.  Because newer versions of Git works either way,
> request-pull used to show tags/for-linus when asked
> 
>     $ git request-pull origin/master $URL for-linus
> 
> The recent updates broke this and in the output we see "for-linus"
> without the "tags/" prefix.
> 
> As v1.7.10 is more than 2 years old, this should matter very little
> in practice, but resurrecting it is very simple.

Well RHEL6 apparently comes with git 1.7.1, there are
probably others.

The problem isn't theorectical actually,
the reason I noticed the change in behaviour is because one of
my pull requests got bounced because of it:
http://article.gmane.org/gmane.comp.emulators.qemu/273121


> Signed-off-by: Junio C Hamano <gitster@pobox.com>


Tested-by: Michael S. Tsirkin <mst@redhat.com>

> ---
> 
>  * I _think_ the fix, without breaking the spirit of Linus's "I do
>    not want the thing DWIM based on what the remote end has"
>    original, would be as simple as this patch.  We can queue it as a
>    regression fix and do another round of -rc4 if those who depend
>    on request-pull heavily feel strongly about it.
> 
>  git-request-pull.sh     | 6 ++++++
>  t/t5150-request-pull.sh | 8 +++++++-
>  2 files changed, 13 insertions(+), 1 deletion(-)
> 
> diff --git a/git-request-pull.sh b/git-request-pull.sh
> index b67513a..d6648b2 100755
> --- a/git-request-pull.sh
> +++ b/git-request-pull.sh
> @@ -118,6 +118,12 @@ then
>  	status=1
>  fi
>  
> +# Special case: turn "for_linus" to "tags/for_linus" when it is correct
> +if test "$ref" = "refs/tags/$pretty_remote"
> +then
> +	pretty_remote=tags/$pretty_remote
> +fi
> +
>  url=$(git ls-remote --get-url "$url")
>  
>  git show -s --format='The following changes since commit %H:
> diff --git a/t/t5150-request-pull.sh b/t/t5150-request-pull.sh
> index 75d6b38..93e2c65 100755
> --- a/t/t5150-request-pull.sh
> +++ b/t/t5150-request-pull.sh
> @@ -223,7 +223,13 @@ test_expect_success 'pull request format' '
>  		git request-pull initial "$downstream_url" tags/full:refs/tags/full
>  	) >request &&
>  	sed -nf fuzz.sed <request >request.fuzzy &&
> -	test_i18ncmp expect request.fuzzy
> +	test_i18ncmp expect request.fuzzy &&
> +
> +	(
> +		cd local &&
> +		git request-pull initial "$downstream_url" full
> +	) >request &&
> +	grep ' tags/full$'
>  '
>  
>  test_expect_success 'request-pull ignores OPTIONS_KEEPDASHDASH poison' '
> -- 
> 2.0.0-rc3-434-g1ba2fe8
