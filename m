From: David Turner <dturner@twopensource.com>
Subject: Re: [PATCH] receive-pack: optionally deny case-clone refs
Date: Tue, 03 Jun 2014 23:05:44 -0400
Organization: Twitter
Message-ID: <1401851144.18134.128.camel@stross>
References: <1401822896-816-1-git-send-email-dturner@twitter.com>
	 <xmqqioohwud5.fsf@gitster.dls.corp.google.com>
	 <1401832959.18134.120.camel@stross>
	 <xmqq61khwsj8.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, David Turner <dturner@twitter.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jun 04 05:05:56 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ws1WV-0003WD-LE
	for gcvg-git-2@plane.gmane.org; Wed, 04 Jun 2014 05:05:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754154AbaFDDFt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 Jun 2014 23:05:49 -0400
Received: from mail-qa0-f44.google.com ([209.85.216.44]:61979 "EHLO
	mail-qa0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753413AbaFDDFs (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Jun 2014 23:05:48 -0400
Received: by mail-qa0-f44.google.com with SMTP id j7so6107658qaq.17
        for <git@vger.kernel.org>; Tue, 03 Jun 2014 20:05:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:organization:content-type:content-transfer-encoding
         :mime-version;
        bh=MVAdTuE9LWZ+agqFXLURVsqRhSCOOaxVw1lk0+3hxi8=;
        b=nC5SHmWwXplFAO1mFeV0ofqaF6boKCSDmdzkfyen6ZHCsEu1leGzDmTZ1PVPGacXgp
         n+KQGtd9FXS86GzN0KUxX9OHGrTq6uRPgw+5Qwus5uMND2WIX3U3sAXYlXCeZE3py9ws
         rbbMYrG+k/taZFFwekPQkqsj4vkBq201GmheBZip7TrP9qVjXqpK1EkePP77xgrB+uas
         XqZv5xbqkDSmyrdrKpLYG8CQUlZIufC8DtO0jqP44xPkKQNnVBuUmEIlIMSev3UVwetI
         YgxVgMcDazXD+7WO6AOhob/cJOOHbQeo3Z8nuEceaUZms4k+v4NgLauyMFqobF7PQ8XV
         bdbg==
X-Gm-Message-State: ALoCoQmsY+etxTRmgX2NkaDznUCt54BJeYVyUewzxbM32hkcJ5CsNPEMSpvfj7035w8UwElxzKzs
X-Received: by 10.140.21.101 with SMTP id 92mr63513612qgk.57.1401851147527;
        Tue, 03 Jun 2014 20:05:47 -0700 (PDT)
Received: from [172.18.24.142] ([8.25.196.25])
        by mx.google.com with ESMTPSA id d89sm830208qga.2.2014.06.03.20.05.45
        for <multiple recipients>
        (version=SSLv3 cipher=RC4-SHA bits=128/128);
        Tue, 03 Jun 2014 20:05:46 -0700 (PDT)
In-Reply-To: <xmqq61khwsj8.fsf@gitster.dls.corp.google.com>
X-Mailer: Evolution 3.2.3-0ubuntu6 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/250710>

On Tue, 2014-06-03 at 15:13 -0700, Junio C Hamano wrote:
> David Turner <dturner@twopensource.com> writes:
> 
> > I would be happy to add "case-clone" to the glossary -- would that be OK
> > with you?  I do not immediately think of the better term.
> 
> Somehow "case-clone" sounds strange, though X-<.

Case clones case clones roly poly case clones; case clones case clones
eat them up yum.  Yeah, I wish I could think of a name that did not call
to mind Tatiana Maslany, but unfortunately, that is all I can think of.
At least it's easy to search for.

> >> (Mental note to the reviewer himself) This returns true iff there is
> >> an existing ref whose name is only different in case, and cause
> >> for-each-ref to return early with true.  In a sane case of not
> >> receiving problematic refs, this will have to iterate over all the
> >> existing refnames.  Wonder if there are better ways to optimize this
> >> in a repository with hundreds or thousands of refs, which is not all
> >> that uncommon.
> >
> > My expectation is that on average a push will involve a small number of
> > refs -- usually exactly one.
> 
> It does not matter that _you_ push only one, because the number of
> existing refs at the receiving end is what determines how many times
> the for-each-ref loop spins, no?

Yes, but that loop is an inner loop; so the total cost is O(refs pushed
* existing refs).  An in-memory hashmap would be O(existing refs) with a
higher constant factor.  An on-disk hashmap would probably scale best,
but a fair amount more work.

> > Yes, but it's harder to test on case-insensitive filesystems because we
> > cannot have coexisting local case-clone branches.
> 
> You do not have to (and you should not) do "git checkout -b" to
> create various local branches in the first place.  For example:
> 
> 	git send-pack ./victim HEAD^1:refs/heads/caseclone &&
> 	test_must_fail git send-pack ./victim HEAD:refs/heads/CaseClone
> 
> would let you push the parent of the current tip to caseclone and
> then attempt to push the current tip to CaseClone.  If the receiving
> end could incorrectly fast-forwards caseclone, you found a bug ;-)

Thanks.
