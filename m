From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] send-email: support NNTP
Date: Wed, 24 Apr 2013 09:17:54 -0700
Message-ID: <7vip3bgax9.fsf@alter.siamese.dyndns.org>
References: <1366715634-21790-1-git-send-email-l.stelmach@samsung.com>
	<7vobd5l277.fsf@alter.siamese.dyndns.org> <87txmw75bb.fsf@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: l.stelmach@samsung.com (=?utf-8?Q?=C5=81ukasz?= Stelmach)
X-From: git-owner@vger.kernel.org Wed Apr 24 18:18:06 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UV2OT-0007Db-NY
	for gcvg-git-2@plane.gmane.org; Wed, 24 Apr 2013 18:18:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755748Ab3DXQSA convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 24 Apr 2013 12:18:00 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:54679 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754376Ab3DXQR7 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 24 Apr 2013 12:17:59 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 5379918FA5;
	Wed, 24 Apr 2013 16:17:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=63vsOTf8bgy4
	elVPIO3N044Xzr8=; b=W853N/dtLZ2uTu+r/2bV3VscAwWBU/n0cHvHlYx2rlQB
	JQHZxfSTA21jaX8EttXbD4yxb3FICdJW83APDfOJl3cCfjtp+2d8y4fz5HWFjeGu
	iFoDHXYZGqnzymrOGRQiD4uWtUS4GMdF4pPclObBbo3O5kHdse0suGm9OEWV/2Y=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=dMW4mn
	KBcjyV0Xb3v3A0P+AcqjFJnXFplts2mx7JpregS7lHkU8tGyN+/ag3yXprJLrVzP
	rw5yTbcFMV+Ll5USsV2zyFI+KsvVcz2tNI9Hm9H8bWtS1TyE3yJjt66pU7t7VuJ+
	aUkM+ztLhgIdkIO66+7sZIxi5g1/Q3WEWShJs=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 484D818FA4;
	Wed, 24 Apr 2013 16:17:57 +0000 (UTC)
Received: from pobox.com (unknown [24.4.35.13])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 8B23418FA3;
	Wed, 24 Apr 2013 16:17:56 +0000 (UTC)
In-Reply-To: <87txmw75bb.fsf@samsung.com> (=?utf-8?Q?=22=C5=81ukasz?=
 Stelmach"'s message of
	"Wed, 24 Apr 2013 09:31:36 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 8613EFF4-ACFA-11E2-8825-BCFF4146488D-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/222257>

l.stelmach@samsung.com (=C5=81ukasz Stelmach) writes:

> It was <2013-04-23 wto 17:02>, when Junio C Hamano wrote:
>> =C5=81ukasz Stelmach <l.stelmach@samsung.com> writes:
>>
>>> Enable sending patches to NNTP servers (Usenet, Gmane).
>>> ---
>>>
>>> The patch implements support for sending messages to groups on NNTP=
 serviers.
>>
>> Cute.
>>
>> A Perl guru might want to encapsulate the differences between $smtp
>> and $nntp codepaths into two Perl modules, but it looks like a good
>> starting point.
>
> You mean *one* perl module like Git::EmailTransport which hides the
> differences.

What I meant was one class to handle SMTP and another for NNTP.

You look at the --protocol option, choose one of these classes, and
initialize an instance of the chosen class.

You can ask the chosen class to instantiate an instance without
if/else cascade like this:

+
+# Transport specific setup
+my ($email_authuser, $email_authpass);
+if ($email_protocol eq 'nntp') {
+    $email_authuser =3D $nntp_authuser;
+    $email_authuser =3D $nntp_authuser;
+    @initial_to =3D @initial_cc =3D @bcclist =3D ();
+    $to_cmd =3D $cc_cmd =3D undef;
+    $no_cc =3D $no_bcc =3D 1;
+} else {
+    $email_authuser =3D $smtp_authuser;
+    $email_authpass =3D $smtp_authpass;
+    $newsgroups_cmd =3D undef;
+}
+

By asking that instance to ask questions to fill in whatever it
needs from the user, you can remove the need of if/elsif cascade
like this part in your patch:

+if ($email_protocol eq 'smtp' && !@initial_to && !defined $to_cmd) {
 	my $to =3D ask("Who should the emails be sent to (if any)? ",
 		     default =3D> "",
 		     valid_re =3D> qr/\@.*\./, confirm_only =3D> 1);
 	push @initial_to, parse_address_line($to) if defined $to; # sanitized=
/validated later
 	$prompting++;
+} elsif ($email_protocol eq 'nntp' &&
+	 !@initial_newsgroups &&
+	 !defined $newsgroups_cmd) {
+	my $newsgroup =3D ask("Which newsgroups should the message be sent to=
 (if any)? ",
+		     default =3D> "",
+		     valid_re =3D> qr/[\x20-\x7f]+/, confirm_only =3D> 1);
+	push @initial_newsgroups, $newsgroup if defined $newsgroup; # sanitiz=
ed/validated later
+	$prompting++;
 }


Naturally, a function like this will become a method of the
instance without if/else cascade:

+sub email_host_string {
+	if ($email_protocol eq 'nntp') {
+		if (defined $nntp_server_port) {
+			return "$nntp_server:$nntp_server_port";
+		} else {
+			return $nntp_server;
+		}
+
 	} else {
-		return $smtp_server;
+		if (defined $smtp_server_port) {
+			return "$smtp_server:$smtp_server_port";
+		} else {
+			return $smtp_server;
+		}
 	}
 }
