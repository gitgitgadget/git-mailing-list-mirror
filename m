From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] test: some testcases failed if cwd is on a symlink
Date: Tue, 24 Jul 2012 07:47:59 -0700
Message-ID: <7vboj5gqqo.fsf@alter.siamese.dyndns.org>
References: <001c60538df409d94618e80cc3faaae586ccf053.1343116581.git.worldhello.net@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git List <git@vger.kernel.org>
To: Jiang Xin <worldhello.net@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jul 24 16:48:10 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1StgPB-0003NA-2C
	for gcvg-git-2@plane.gmane.org; Tue, 24 Jul 2012 16:48:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754216Ab2GXOsD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 Jul 2012 10:48:03 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:58415 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754022Ab2GXOsB (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Jul 2012 10:48:01 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 8DCB17027;
	Tue, 24 Jul 2012 10:48:01 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=5QBjZ3dyBKWCV/HYk3flw8dN2js=; b=LzXNJx
	OpdSm0uqZkSJDgKDkSoYVofS/lFvJfRFbmidoGYjiFbx/GUlY+7Es9BKghd26QKk
	3rBqWbSrGtZSw/o6TosKMDgoeWNBcAp4niCKP3XTWbXgb0+5xoaUCZi+TOaMzGF+
	gDH7/6/2hiolfN2Ut4tU2psa6JM6H/vqrWybo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Qa4gZsgiJH6O3cpeV/+Voco7FfXezI0o
	16SESPlpWWM3qwp/yUie4pYto0CgF5Lr8LfknYEajX4hTfZQutO+zQwgABvtB/Ah
	ng8xs/LoijaWB5iICE61qd9R7k6COrShmpljMLy//VtAUndLMIcWER52tVbS70Zt
	VI0HjPLNS2s=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 7A1BE7026;
	Tue, 24 Jul 2012 10:48:01 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id D0E207023; Tue, 24 Jul 2012
 10:48:00 -0400 (EDT)
In-Reply-To: <001c60538df409d94618e80cc3faaae586ccf053.1343116581.git.worldhello.net@gmail.com> (Jiang Xin's message of "Tue, 24 Jul 2012 16:00:01 +0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 90CB941C-D59E-11E1-AB0B-01B42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/202043>

Jiang Xin <worldhello.net@gmail.com> writes:

> Run command 'git rev-parse --git-dir' under subdir will return realpath
> of '.git' directory. Some test scripts compare this realpath against
> "$TRASH_DIRECTORY", they are not equal if current working directory is
> on a symlink.
>
> In this fix, get realpath of "$TRASH_DIRECTORY", store it in
> "$TRASH_REALPATH" variable, and use it when necessary.

I wonder if running test in a real directory (in other words, "fix"
your cwd) may be a simpler, more robust and generally a better
solution, e.g. something silly like...

diff --git a/t/test-lib.sh b/t/test-lib.sh
index acda33d..7f6fb0a 100644
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -15,6 +15,8 @@
 # You should have received a copy of the GNU General Public License
 # along with this program.  If not, see http://www.gnu.org/licenses/ .
 
+cd "$(pwd -P)"
+
 # if --tee was passed, write the output not only to the terminal, but
 # additionally to the file test-results/$BASENAME.out, too.
 case "$GIT_TEST_TEE_STARTED, $* " in
