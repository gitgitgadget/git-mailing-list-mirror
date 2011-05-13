From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH/RFC v5] git-p4: warn if git authorship won't be retained
Date: Thu, 12 May 2011 22:29:55 -0700
Message-ID: <7vaaerb224.fsf@alter.siamese.dyndns.org>
References: <1305176756-27046-1-git-send-email-luke@diamand.org>
 <1305176756-27046-2-git-send-email-luke@diamand.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Pete Wyckoff <pw@padd.com>
To: Luke Diamand <luke@diamand.org>
X-From: git-owner@vger.kernel.org Fri May 13 07:30:18 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QKkx5-0005Be-3y
	for gcvg-git-2@lo.gmane.org; Fri, 13 May 2011 07:30:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755989Ab1EMFaI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 13 May 2011 01:30:08 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:40133 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755794Ab1EMFaH (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 13 May 2011 01:30:07 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 462BE32A4;
	Fri, 13 May 2011 01:32:11 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=7GDLx5KYDUz7tnBZij2kHE1FVDI=; b=E8RkcV
	uI8DvD2WfYyAWj33cvLvpCxf2bXa9V50l9VHIZQmi+5Go/YAlm/0MUpjLh8wKTsF
	t6AwamgsjlYAWbJE17DLQl6zEPEbgEYSoh2X+kRmjUrheEYOBRaxj66B0frpXiWs
	HpW4qgF5nbAjXiJPEWVSYxdMaM5TrGXRJEcwk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=T3ExwGAogALysPWdqJwF2Mr6G7LmSNpD
	FY7aLdBi7mRF2OLkjGvyHSY3BOKnKtwryD/WYsMwCX0FJyfDE5l726oz0g3pjqlx
	DvwHJ8hcTr4mUnqKV/UdcRBCTOJrAoCWLTRrYFGLuo4Ss2LIEp6LElyxORst6qkW
	qZJWBB1EEps=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 132B03295;
	Fri, 13 May 2011 01:32:08 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 802663291; Fri, 13 May 2011
 01:32:03 -0400 (EDT)
In-Reply-To: <1305176756-27046-2-git-send-email-luke@diamand.org> (Luke
 Diamand's message of "Thu, 12 May 2011 06:05:56 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 57FAD89E-7D22-11E0-8668-BBB7F5B2FB1A-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/173503>

Luke Diamand <luke@diamand.org> writes:

> diff --git a/t/t9800-git-p4.sh b/t/t9800-git-p4.sh
> index 4fb0e24..888ad54 100755
> --- a/t/t9800-git-p4.sh
> +++ b/t/t9800-git-p4.sh
> @@ -160,6 +160,15 @@ p4_check_commit_author() {
>      fi
>  }
>  
> +make_change_by_user() {
> +	file=$1
> +	name=$2
> +	email=$3
> +	echo "username: a change by $name" >> $file &&
> +	git add $file &&
> +	git commit --author "$name <$email>" -m "a change by $name"
> +}

This should be:

        make_change_by_user() {
                file=$1 name=$2 email=$3 &&
                echo "username: a change by $name" >>"$file" &&
                git add "$file" &&
                git commit --author "$name <$email>" -m "a change by $name"
        }

Points to keep in mind:

 - An assignment is just an ordinary stmt. Make it a habit to keep it as
   part of && chain without having to even think about it, so that you
   won't forget to do so when you need to assign in the middle of a
   sequence.

 - Recent bash seems to give unnecessary warning to redirecting to a
   file whose name is given as a variable. Use a(n unnecessary) double
   quotes to avoid it.

 - Our coding convention is not to have an extra SP after redirection.

 - Double quote your variables where syntactically necessary to avoid them
   from getting split by the shell when they contain IFS whitespaces.

> +# If we're *not* using --preserve-user, git-p4 should warn if we're submitting
> +# changes that are not all ours.
> +# Test: user in p4 and user unknown to p4.
> +# Test: warning disabled and user is the same.
> +test_expect_success 'not preserving user with mixed authorship' '
> +	"$GITP4" clone --dest="$git" //depot &&
> +	(
> +	cd "$git" &&

I'd prefer to see this block inside the "(" ... ")" indented one level
deeper, i.e.

	"$GITP4" clone --dest="$git" //depot &&
        (
		cd "$git" &&
                ...

> +	git config git-p4.skipSubmitEditCheck true &&
> +	p4_add_user derek Derek &&
> +
> +	make_change_by_user usernamefile3 Derek derek@localhost &&
> +	(P4EDITOR=cat P4USER=alice P4PASSWD=secret "$GITP4" commit |
> +		grep "git author derek@localhost does not match" > /dev/null) &&

Are you expecting this '"$GITP4" commit' to succeed (i.e. exit with 0
status), or to fail (i.e. exit with non-zero status)?  By having the
command on the upstream side of a pipe, you cannot check its exit status.

Either

	P4EDITOR=cat P4USER=alice P4PASSWD=secret "$GITP4" commit >actual &&
        grep "git author ..." actual &&

or if you expect the '"$GITP4" commit' to fail:

	! P4EDITOR=cat P4USER=alice P4PASSWD=secret "$GITP4" commit >actual &&
        grep "git author ..." actual &&

Do you really need to discard the output from grep?  When the test is run
without "-v", the output would not be shown, and when it is run with "-v",
showing the output would help you diagnose bugs in the test, no?

If you indeed need to squelch grep, "grep -q" should be usable.  It is
used in many other tests.

I also do not see a need for using a subshell for this case, either.

> +	git diff --exit-code HEAD..p4/master &&

Is it possibile for the working tree files to have changed from p4/master,
and if so is it an error you may want to catch?  Your answer could be "No,
$GITP4 never touches the working tree, so that is unnecessary to check."

> +	make_change_by_user usernamefile3 Charlie charlie@localhost &&
> +	(P4EDITOR=cat P4USER=alice P4PASSWD=secret "$GITP4" commit |
> +		grep "git author charlie@localhost does not match" > /dev/null) &&
> +	git diff --exit-code HEAD..p4/master &&
> +
> +	make_change_by_user usernamefile3 alice alice@localhost &&
> +	!(P4EDITOR=cat P4USER=alice P4PASSWD=secret "$GITP4" commit |
> +		grep "does not match" > /dev/null) &&

Again, either

	P4EDITOR=cat P4USER=alice P4PASSWD=secret "$GITP4" commit >actual &&
        ! grep "does not match" actual

or

	! P4EDITOR=cat P4USER=alice P4PASSWD=secret "$GITP4" commit >actual &&
        ! grep "does not match" actual

depending on what exit status you are expecting from '"$GITP4" commit'.
