From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH] Avoid errors from git-rev-parse in gitweb blame
Date: Tue, 3 Jun 2008 23:31:43 +0200
Message-ID: <200806032331.44514.jnareb@gmail.com>
References: <940824.46903.qm@web31808.mail.mud.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Rafael Garcia-Suarez <rgarciasuarez@gmail.com>,
	git@vger.kernel.org, Lea Wiemann <lewiemann@gmail.com>
To: Luben Tuikov <ltuikov@yahoo.com>
X-From: git-owner@vger.kernel.org Tue Jun 03 23:33:34 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K3e8I-0001cQ-Mh
	for gcvg-git-2@gmane.org; Tue, 03 Jun 2008 23:33:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753783AbYFCVbv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 Jun 2008 17:31:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753597AbYFCVbu
	(ORCPT <rfc822;git-outgoing>); Tue, 3 Jun 2008 17:31:50 -0400
Received: from nf-out-0910.google.com ([64.233.182.188]:42461 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753254AbYFCVbt (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Jun 2008 17:31:49 -0400
Received: by nf-out-0910.google.com with SMTP id d3so679466nfc.21
        for <git@vger.kernel.org>; Tue, 03 Jun 2008 14:31:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        bh=nHEfRu0BJoS5dylesJbPzuO1gomkkGmiaBYe2rbwt9w=;
        b=YBXKnEFfyxLVcHda6egkf1EwP2cxZp1KN8OK7dyZKwKbhjAmIZZm4H1m5ta31FeIawTXgPW9vJcnsg0MtbRoR1utGRF2DMVsTIZfhYGXJuYvPEdT5o8rPbEqvV2P7eEqq0dTMoC2sNLqoKlReti4DyIyT7C6PZ6fjCR01M8HOv8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=juM7CMcOB3kPWndh74eNlYSoqMNFvQZjTfRXQen28wkhNE3kdX01mOV84Li/UyPG0QQMxCIUY39s46twSXMamflAppaDLnEJG572yO2r8K16aUMX3HbDrMxhTYet2zhMT73rKQKoGY/lyOPEKet+FpoMSbzEUFHgeil0DB8ct6o=
Received: by 10.210.109.10 with SMTP id h10mr7797355ebc.170.1212528706940;
        Tue, 03 Jun 2008 14:31:46 -0700 (PDT)
Received: from ?192.168.1.15? ( [83.8.251.199])
        by mx.google.com with ESMTPS id g11sm903835gve.8.2008.06.03.14.31.43
        (version=SSLv3 cipher=RC4-MD5);
        Tue, 03 Jun 2008 14:31:46 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <940824.46903.qm@web31808.mail.mud.yahoo.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/83714>

On Tue, 3 Jan 2008, Luben Tuikov wrote:
> On Tue, 6/3/08, Rafael Garcia-Suarez <rgarciasuarez@gmail.com> wrote:
>> 2008/6/3 Jakub Narebski <jnareb@gmail.com> wrote:
>>>
>>> I was thinking about extending git-blame porcelain format (and also
>>> incremental format, of course) by 'parents' (and perhaps
>>> 'original-parents') header...
>> 
>> OK, I see. That would be nice. Also: currently taking "$full_rev^"
>> directs the user to the parent commit, but it would be more
>> user-friendly to point at the previous commit where the selected file
>> was modified instead.
> 
> The intention was that it shouldn't necessarily be the (strict) parent
> of the change (changed segment), since it may or may not have changed
> in the strict parent commit.  The intention was that it
> "starts"/"opens" the parent commit so that "git" would start from
> there and find the actual change/commit where that line/segment has
> changed.  And it has worked pretty fine for me when data-mining
> (something I do quite often) code evolution.
> 
> My commit 244a70e608204a515c214a11c43f3ecf7642533a was really derived
> from a command line, which I had started to use quite often and had
> been "looking for" for quite some time.

Let us assume for a bit that history is linear, and looks like this:

    ...*---A---*---*---b---.---D^---D---*---x

where 'x' is starting point (revision we start running git-blame from),
'D' is revision given line is blamed on, 'D^' is parent of revision 'D',
'b' is previous commit in a given file history, and 'A' is previous 
commit which modifies given line of a given commit.

It means that the history looks like below
  $ git rev-list x
  [...]
  D
  D^
  .
  b
  [...]
while history of a given file looks like this
  $ git rev-list x -- file
  [...]
  D
  b
  [...]

Now for all commits in the b..D^ range (between D^ and b, including 
endpoints), given file has the same contents, and therefore 'blame' 
view would also look the same.  That is why it works.


The only problem I can see when blamed commit is merge commit; D^ means 
D^1, ehich mesna first parent.  Now, I think that merge commit might be 
blamed _only_ if it was "evil merge" (change/line didn't came from any 
of parents).  But this is quite rare situation; additionally the bug is 
not very visible; when clicking on link you would go to not correct 
view, but this not-correctness isn't obvious on the first glance.
-- 
Jakub Narebski
Poland
