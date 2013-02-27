From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCHv4 6/6] git-send-email: use git credential to obtain
 password
Date: Wed, 27 Feb 2013 07:54:46 -0800
Message-ID: <7vehg1kb09.fsf@alter.siamese.dyndns.org>
References: <cover.1360677646.git.mina86@mina86.com>
 <cover.1360677646.git.mina86@mina86.com>
 <32bae1f3c7159035ea3fb5f61ab622cbff30293a.1360677646.git.mina86@mina86.com>
 <vpqhakx4z4c.fsf@grenoble-inp.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Michal Nazarewicz <mpn@google.com>, peff@peff.net,
	git@vger.kernel.org
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Wed Feb 27 16:55:18 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UAjLf-0001L8-Lx
	for gcvg-git-2@plane.gmane.org; Wed, 27 Feb 2013 16:55:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757833Ab3B0Pyu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 Feb 2013 10:54:50 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:36556 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757487Ab3B0Pyt (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Feb 2013 10:54:49 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 36115ADBF;
	Wed, 27 Feb 2013 10:54:49 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=s3OAjfDUE3UqB/504xZsz3ktxYk=; b=XYXKhs
	dKjFHHFgpRgT+AuNN52NbIZYKpcpegR/qWYY04X3vwUTbm4mZ6m9ecRISD2g5v+X
	9Txs0Wz/5VmvG1/CoAPGRqxV6HnmgBkX0uTZpIcU6+CW5MDqJNyl4F5juvX2S61H
	xtKCa+ysbqOEN4hcZOwzNI0rSgc7Zd7IXzk6A=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=r5pmtqxB4fni1RAMFNN42nShdddDbdhC
	jegx3xGl/pv5Q3kAMSHCXAvfhT+rhFW9bULIH3FS50Z4e0EGZ8D51E5GDSohzxMF
	fr+6AdKc+pzbzPFgxRU0xlrttexN2hQVPImMrY1fLy6IqEnNe7UWAhwO7q+9mD29
	HCHv3RW0Ciw=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 2A640ADBE;
	Wed, 27 Feb 2013 10:54:49 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 7EDC3ADBD; Wed, 27 Feb 2013
 10:54:48 -0500 (EST)
In-Reply-To: <vpqhakx4z4c.fsf@grenoble-inp.fr> (Matthieu Moy's message of
 "Wed, 27 Feb 2013 15:20:35 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 039A436E-80F6-11E2-A916-F3C82E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/217213>

Matthieu Moy <Matthieu.Moy@grenoble-inp.fr> writes:

> Michal Nazarewicz <mpn@google.com> writes:
>
>> +	$auth = Git::credential({
>> +		'protocol' => 'smtp',
>> +		'host' => join(':', $smtp_server, $smtp_server_port),
>
> At this point, $smtp_server_port is not always defined. I just tested
> and got
>
> Use of uninitialized value $smtp_server_port in join or string at
> git-send-email line 1077.
>
> Other than that, the whole series looks good.

Given that there is another place that conditionally append ":$port"
to the host string, I think we should follow suit here.  Perhaps
like the attached diff?

Thanks for a review.


 git-send-email.perl | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/git-send-email.perl b/git-send-email.perl
index 76bbfc3..c3501d9 100755
--- a/git-send-email.perl
+++ b/git-send-email.perl
@@ -1045,6 +1045,14 @@ sub maildomain {
 	return maildomain_net() || maildomain_mta() || 'localhost.localdomain';
 }
 
+sub smtp_host_string {
+	if (defined $smtp_server_port) {
+		return "$smtp_server:$smtp_server_port";
+	} else {
+		return $smtp_server;
+	}
+}
+
 # Returns 1 if authentication succeeded or was not necessary
 # (smtp_user was not specified), and 0 otherwise.
 
@@ -1065,7 +1073,7 @@ sub smtp_auth_maybe {
 	# reject credentials.
 	$auth = Git::credential({
 		'protocol' => 'smtp',
-		'host' => join(':', $smtp_server, $smtp_server_port),
+		'host' => smtp_host_string(),
 		'username' => $smtp_authuser,
 		# if there's no password, "git credential fill" will
 		# give us one, otherwise it'll just pass this one.
@@ -1188,9 +1196,7 @@ sub send_message {
 		else {
 			require Net::SMTP;
 			$smtp_domain ||= maildomain();
-			$smtp ||= Net::SMTP->new((defined $smtp_server_port)
-						 ? "$smtp_server:$smtp_server_port"
-						 : $smtp_server,
+			$smtp ||= Net::SMTP->new(smtp_host_string(),
 						 Hello => $smtp_domain,
 						 Debug => $debug_net_smtp);
 			if ($smtp_encryption eq 'tls' && $smtp) {
