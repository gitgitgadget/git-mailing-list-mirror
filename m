From: "Ping Yin" <pkufranky@gmail.com>
Subject: Re: [PATCH 2/7] git-submodule: Extract absolute_url & move absolute url logic to module_clone
Date: Tue, 22 Apr 2008 22:41:35 +0800
Message-ID: <46dff0320804220741p4d3f3080w493fb96dc4983a1c@mail.gmail.com>
References: <1208355577-8734-1-git-send-email-pkufranky@gmail.com>
	 <1208355577-8734-2-git-send-email-pkufranky@gmail.com>
	 <1208355577-8734-3-git-send-email-pkufranky@gmail.com>
	 <7v3ape5sip.fsf@gitster.siamese.dyndns.org>
	 <46dff0320804212350t647492b2o649ddc40cfe43d6@mail.gmail.com>
	 <7v3ape2ufs.fsf@gitster.siamese.dyndns.org>
	 <46dff0320804220209n590a0684x876270c7b1c0c2d@mail.gmail.com>
	 <46dff0320804220738u760a05f7q4ec9cbf144d78480@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Junio C Hamano" <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Apr 22 16:43:50 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JoJhR-0000nJ-67
	for gcvg-git-2@gmane.org; Tue, 22 Apr 2008 16:42:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755648AbYDVOlh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 22 Apr 2008 10:41:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754990AbYDVOlh
	(ORCPT <rfc822;git-outgoing>); Tue, 22 Apr 2008 10:41:37 -0400
Received: from wx-out-0506.google.com ([66.249.82.235]:64719 "EHLO
	wx-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755256AbYDVOlg (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 Apr 2008 10:41:36 -0400
Received: by wx-out-0506.google.com with SMTP id h31so1816465wxd.4
        for <git@vger.kernel.org>; Tue, 22 Apr 2008 07:41:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=Gt1K/iMJbex5Bnvs5VJhwK5HhKScJY73WOe8z16c8CI=;
        b=DSMPJMe0+Ucfzui+sr3oPhnAZ+DuA4xAoJMSKMQ3Grr46h9B2tZq7F322DQzaZzkDPmLnleMzez/KnzRcLsh925VcJ3EHrmBkT8dtIpKQQNojRNaeU9k5AeuHV9kA7ieqHM1Y+5MoLPcPGJPSq0Z4/8Jwv0Dw0e5MTPWHb7nBkU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=lJu4TNInVoBLpheMNqNgrqaJAjjB1keXiZVETcyV7mTy/oL6mKA8ahMQoXuhD529XQxmWvi6XkqIV22iNVbf/L5Hz3YL/sv8LEKPDaFJBUEci88ezr8QxLhBiZw1RGiiSWEFlj05vZu6dxDlixf+U92qbv6g8XZQ+bygztKaYOk=
Received: by 10.100.134.10 with SMTP id h10mr461631and.117.1208875295686;
        Tue, 22 Apr 2008 07:41:35 -0700 (PDT)
Received: by 10.100.32.10 with HTTP; Tue, 22 Apr 2008 07:41:35 -0700 (PDT)
In-Reply-To: <46dff0320804220738u760a05f7q4ec9cbf144d78480@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/80126>

On Tue, Apr 22, 2008 at 10:38 PM, Ping Yin <pkufranky@gmail.com> wrote:
> >  >  Please have that kind of justification in the proposed commit log message.
>  >  >  When these changes are made into history, people cannot ask you questions
>  >  >  like I did and expect the history to produce such answer on demand ;-)
>  >  >
>  >
>  >  OK, i'll resend this patch tonight.
>
>  See attached patch

Only the commit message changes.


git-submodule: Fix inconsistent handling of relative urls with './' prefix

There is a little inconsistence in current handling of relative url
with "./"

- "git submodule add ./foo" will clone the submodule with url
  "${remote.origin.url}/foo" and init an entry 'submodule.foo.url=./foo"
  in .gitmodules

- "git submodule init" will init an entry in $GIT_DIR/config as
  "submodule.foo.url=${remote.origin.url}/foo"

- However, if there is an entry "submodule.foo.url=./foo" in
  $GIT_DIR/config, "git submodule update" will not expand
  "./foo" with remote.origin.url

This patch unifies the behaviour of handling relative urls with './'
prefix. Now "git submodule init" copies urls from .gitmodules to
$GIT_DIR/config as is without expanding. And the url expanding happens
only at runtime, say when "git submodule add" or "git submodule update".

absolute_url is extracted to remove code redundance and fix inconsistence
in cmd_init and cmd_add when resolving relative url/path to absolute one.

Also move resolving absolute url logic from cmd_add to module_clone which
results in the expected behaviour change: cmd_update will resolve url
'./foo' in $GIT_DIR/config as "${remote.origin.url}/foo" instead of
"$(pwd)/foo".

This behaviour change breaks t7400 which uses relative url './.subrepo'.
However, this test originally doesn't mean to test relative url with './'
prefix, so fix the url as '.subrepo'.



-- 
Ping Yin
