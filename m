From: Lukas Fleischer <lfleischer@lfos.de>
Subject: Re: [PATCH 4/4] t5509: add basic tests for hideRefs
Date: Mon, 02 Nov 2015 07:25:19 +0100
Message-ID: <20151102062449.24971.39537@typhoon>
References: <1446406463-22527-1-git-send-email-lfleischer@lfos.de>
 <1446406463-22527-5-git-send-email-lfleischer@lfos.de>
 <CAPig+cR7sCqigz=--_d-bW0X=+vpbV-_N9hxriLH9fMjLJUfsA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8BIT
Cc: "Git List" <git@vger.kernel.org>
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Mon Nov 02 07:25:28 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Zt8YZ-0006Fv-J6
	for gcvg-git-2@plane.gmane.org; Mon, 02 Nov 2015 07:25:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751650AbbKBGZX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 2 Nov 2015 01:25:23 -0500
Received: from elnino.cryptocrack.de ([46.165.227.75]:18111 "EHLO
	elnino.cryptocrack.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751356AbbKBGZX convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 2 Nov 2015 01:25:23 -0500
Received: by elnino.cryptocrack.de (OpenSMTPD) with ESMTPSA id 906af141;
	TLS version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NO;
	Mon, 2 Nov 2015 07:25:20 +0100 (CET)
In-Reply-To: <CAPig+cR7sCqigz=--_d-bW0X=+vpbV-_N9hxriLH9fMjLJUfsA@mail.gmail.com>
User-Agent: alot/0.3.6
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/280682>

On Sun, 01 Nov 2015 at 22:13:51, Eric Sunshine wrote:
> On Sun, Nov 1, 2015 at 2:34 PM, Lukas Fleischer <lfleischer@lfos.de> wrote:
> > Test whether regular and full hideRefs patterns work as expected when
> > namespaces are used.
> >
> > Signed-off-by: Lukas Fleischer <lfleischer@lfos.de>
> > ---
> > diff --git a/t/t5509-fetch-push-namespaces.sh b/t/t5509-fetch-push-namespaces.sh
> > @@ -82,4 +82,33 @@ test_expect_success 'mirroring a repository using a ref namespace' '
> >         )
> >  '
> >
> > +test_expect_success "Hide namespaced refs with transfer.hideRefs" '
> 
> None of the other tests in this file capitalize the test description.
> These new test descriptions should probably follow suit by beginning
> with lowercase. It is also typical to use single quotes for the
> description rather than double.
> 

Good catch. I originally put these tests somewhere else and noticed that
adding them to t5509 is much better since we already set up the whole
namespace infrastructure there. Seems like I forgot to adjust the style.
Fixed that locally.

> > +       cd pushee &&
> > +       test_config transfer.hideRefs refs/tags &&
> > +       GIT_NAMESPACE=namespace git ls-remote "ext::git %s ." >actual &&
> > +       printf "$commit1    refs/heads/master\n" >expected &&
> > +       test_cmp expected actual &&
> > +       cd ..
> 
> If any of the commands above "cd .." fail, then "cd .." will never be
> invoked, thus subsequent tests will fail since they won't be executed
> in the expected directory. The typical way to handle this is to place
> the "cd foo" and remaining test body in a subshell, and drop "cd .."
> altogether. When the subshell exits (via success or failure), the
> working directory will be restored automatically.
> 
>     test_expect_success '...' '
>         (
>             cd pushee &&
>             test_config ... &&
>             ...
>         )
>     '
> [...]

I chose the `cd ..` approach because test_config does not work from a
subshell. However, searching the Git log for "test_config", I found
1a9a23e (t7610: don't use test_config in a subshell, 2015-09-05) and
da568b6 (t7800: don't use test_config in a subshell, 2015-09-05) which
suggest to use the -C switch. The test cases now look like this:

    test_expect_success '[...]' '
        test_config -C pushee transfer.hideRefs [...] &&
        (
            cd pushee &&
            [...]
        )
    '

Thanks!
