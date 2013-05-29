From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH 1/6] t/send-email.sh: add test for suppress self
Date: Thu, 30 May 2013 00:44:03 +0300
Message-ID: <20130529214403.GA5956@redhat.com>
References: <1369579187-27573-1-git-send-email-mst@redhat.com>
 <1369579187-27573-2-git-send-email-mst@redhat.com>
 <7vy5axr0mz.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed May 29 23:43:46 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Uho9n-0004Go-AM
	for gcvg-git-2@plane.gmane.org; Wed, 29 May 2013 23:43:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S935237Ab3E2Vnk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 29 May 2013 17:43:40 -0400
Received: from mx1.redhat.com ([209.132.183.28]:62229 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S935223Ab3E2Vni (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 29 May 2013 17:43:38 -0400
Received: from int-mx09.intmail.prod.int.phx2.redhat.com (int-mx09.intmail.prod.int.phx2.redhat.com [10.5.11.22])
	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id r4TLhal2010559
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK);
	Wed, 29 May 2013 17:43:36 -0400
Received: from redhat.com (vpn-203-5.tlv.redhat.com [10.35.203.5])
	by int-mx09.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with SMTP id r4TLhXmF006830;
	Wed, 29 May 2013 17:43:34 -0400
Content-Disposition: inline
In-Reply-To: <7vy5axr0mz.fsf@alter.siamese.dyndns.org>
X-Scanned-By: MIMEDefang 2.68 on 10.5.11.22
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/225894>

On Wed, May 29, 2013 at 01:28:52PM -0700, Junio C Hamano wrote:
> "Michael S. Tsirkin" <mst@redhat.com> writes:
> 
> > Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> > ---
> 
> Thanks.

Thanks, I'll address your comments and repost.
You asked some questions below, so I tried to answer.

> >  t/t9001-send-email.sh | 41 +++++++++++++++++++++++++++++++++++++++++
> >  1 file changed, 41 insertions(+)
> >
> > diff --git a/t/t9001-send-email.sh b/t/t9001-send-email.sh
> > index ebd5c5d..36ecf73 100755
> > --- a/t/t9001-send-email.sh
> > +++ b/t/t9001-send-email.sh
> > @@ -171,6 +171,47 @@ Result: OK
> >  EOF
> >  "
> >  
> > +test_suppress_self () {
> > +		test_commit $3 &&
> > +		test_when_finished "git reset --hard HEAD^" &&
> > +		{
> > +			echo "#!$SHELL_PATH"
> > +			echo sed -n -e s/^cccmd--//p \"\$1\"
> > +		} > cccmd-sed &&
> > +		chmod +x cccmd-sed &&
> 
> We can use write_script for this kind of thing, I think.

Important?
It's open-coded elsewhere in this test.

> > +		git commit --amend --author="$1 <$2>" -F - << EOF && \
> 
> Hmm,...  everything below this function is fed as the standard input
> to "git commit" as its updated log message (i.e. "--amend -F -")?
> 
> Puzzled...
> The EOF I can find is at the very bottom of this function, so there
> is no "next command" that && at the end of the above line is
> cascading the control to.
> 
> Doubly puzzled...
> 
> In any case, please do not add " \" at the end of line when the line
> ends one command and "&&" at the end of line clearly tells the shell
> that you haven't stopped talking yet.


Note that \ make following lines count as continuation of this one.
So they are *not* part of standard input.

Look here:

FOO << EOF && BAR && VAR
BLABLA
EOF

this feeds BLABLA as input to FOO, then
runs BAR and then VAR.

Now we don't want to put BAR and VAR on same line
because that line is too long.
So we write the equivalent: \ followed by newline
is same as space for shell, so we can write it as:

FOO << EOF && \
 BAR && \
 VAR
BLABLA
EOF

Clear now?

If we don't want to use \, this can also
be done like this:

FOO << EOF && 
BLABLA
EOF
 BAR && 
 VAR

I think this is what you suggest.


> 
> > +		clean_fake_sendmail && \
> > +		echo suppress-self-$3.patch > /dev/tty && \
> 
> Do we always have /dev/tty?  If this is a leftover debugging, please
> remove it.

Leftover.

>  If redirecting it to >&2 does not upset what the test
> does, that is good, too (you can run the test with -v option to view
> the output).
> 
> > +		git format-patch --stdout -1 >suppress-self-$3.patch && \
> > +		git send-email --from="$1 <$2>" \
> > +		--to=nobody@example.com \
> > +		--cc-cmd=./cccmd-sed \
> > +		--suppress-cc=self \
> > +		--smtp-server="$(pwd)/fake.sendmail" \
> > +		suppress-self-$3.patch && \
> > +		mv msgtxt1 msgtxt1-$3 && \
> > +		sed -e '/^$/q' msgtxt1-$3 > msghdr1-$3 && \
> 
> Style.  No SP between redirection operator and redirection target,
> e.g. >$filename, <$filename, etc.  Some in this patch is done
> correctly (e.g. format-patch above), some others are not.

will fix.

> > +		rm -f expected-no-cc-$3 && \
> > +		touch expected-no-cc-$3 && \
> 
> Please reserve "touch" for "make sure it has recent timestamp", not
> for "make sure it exists and is empty".  The above two should be
> more like:
> 
> 		>"expected-no-cc-$3" &&

OK

> Also, even though it is not required by POSIX, please dquote the
> redirection target filename if you have variable expansion.  Some
> versions of bash (incorrectly) give warning if you don't.

OK

> > +		grep '^Cc:' msghdr1-$3 > actual-no-cc-$3 && \
> > +		test_cmp expected-no-cc-$3 actual-no-cc-$3
> > +test suppress-cc.self $3 with name $1 email $2
> > +
> > +$3
> > +
> > +cccmd--"$1" <$2>
> > +
> > +Cc: "$1" <$2>
> > +Cc: $1 <$2>
> > +Signed-off-by: "$1" <$2>
> > +Signed-off-by: $1 <$2>
> > +EOF
> > +}
> > +
> > +test_expect_success $PREREQ 'self name is suppressed' "
> > +	test_suppress_self 'A U Thor' 'author@redhat.com' 'self_name_suppressed'
> > +"
> > +
> >  test_expect_success $PREREQ 'Show all headers' '
> >  	git send-email \
> >  		--dry-run \
