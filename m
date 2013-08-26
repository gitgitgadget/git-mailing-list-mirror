From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [RFC/PATCH] git-remote-mediawiki: reset private ref after non-dumb push
Date: Mon, 26 Aug 2013 11:16:05 +0200
Message-ID: <vpqr4dgizhm.fsf@anie.imag.fr>
References: <1376400700-8863-1-git-send-email-Matthieu.Moy@imag.fr>
	<CAMP44s2u1edB3g9GK_kak3Nc-fe4TDBjFU_JqskBW+J0Q9BJrg@mail.gmail.com>
	<vpqa9ka7mku.fsf@anie.imag.fr>
	<CAMP44s3jh4iEbgONaEU0WSCc5YiGYoK8edcgWU6qmUARToVRuw@mail.gmail.com>
	<vpqbo4o3jba.fsf@anie.imag.fr>
	<CAMP44s281qkdMXUM-2P6T+emFajASX6Jyj4nk8_cU5xYJYvdLA@mail.gmail.com>
	<vpq8uzr5y4v.fsf@anie.imag.fr>
	<xmqq61uumnsz.fsf@gitster.dls.corp.google.com>
	<vpqhaeckfbh.fsf@anie.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Felipe Contreras <felipe.contreras@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Aug 26 11:16:16 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VDsuE-0007bg-W4
	for gcvg-git-2@plane.gmane.org; Mon, 26 Aug 2013 11:16:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756229Ab3HZJQL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 26 Aug 2013 05:16:11 -0400
Received: from mx1.imag.fr ([129.88.30.5]:39380 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755359Ab3HZJQK (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 26 Aug 2013 05:16:10 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id r7Q9G4mb021782
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Mon, 26 Aug 2013 11:16:04 +0200
Received: from anie.imag.fr ([129.88.7.32])
	by mail-veri.imag.fr with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.72)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1VDsu5-0001rp-Dr; Mon, 26 Aug 2013 11:16:05 +0200
In-Reply-To: <vpqhaeckfbh.fsf@anie.imag.fr> (Matthieu Moy's message of "Mon,
	26 Aug 2013 10:48:50 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Mon, 26 Aug 2013 11:16:05 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: r7Q9G4mb021782
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1378113365.0551@BM4E1S69bH724kPdlDd2pA
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/232988>

Matthieu Moy <Matthieu.Moy@grenoble-inp.fr> writes:

> Junio C Hamano <gitster@pobox.com> writes:
>
>> Matthieu Moy <Matthieu.Moy@grenoble-inp.fr> writes:
>>
>>> How would I do that? The update to the remote namespace is done by Git,
>>> not by the remote-helper.
>>>
>>> OK, I'm now convinced that my solution is the right one. The
>>> alternatives are far more complex and I still fail to see the benefits.
>>
>> Sounds like a plan, even though it smells like the "update is done
>> by Git" that does not have any way to opt-out may be the real design
>> mistake and your "solution" is a work-around to that.
>>
>> Would it be a possibility to make it tunable, perhaps by introducing
>> a capability on the remote-interface side that allows you to tell it
>> not to mess with the remote namespace?
>
> Ideally, it would be possible to ask for a non-update without a fatal
> error on old Git versions, but this is not possible (hence, my fix is
> the "portable" one, that works on Git 1.8.4).
>
> But that's probably the best we can do now.

... and a patch implementing that would look like:

commit e438ddc58a3cedcf66332bddda792954c5905cea
Author: Matthieu Moy <Matthieu.Moy@imag.fr>
Date:   Mon Aug 26 11:10:30 2013 +0200

    transport-helper: add dont-update-private capability

diff --git a/transport-helper.c b/transport-helper.c
index 63cabc3..639b0e3 100644
--- a/transport-helper.c
+++ b/transport-helper.c
@@ -27,7 +27,8 @@ struct helper_data {
                push : 1,
                connect : 1,
                signed_tags : 1,
-               no_disconnect_req : 1;
+               no_disconnect_req : 1,
+               dont_update_private : 1;
        char *export_marks;
        char *import_marks;
        /* These go from remote name (as in "list") to private name */
@@ -205,6 +206,8 @@ static struct child_process *get_helper(struct transport *transport)
                        strbuf_addstr(&arg, "--import-marks=");
                        strbuf_addstr(&arg, capname + strlen("import-marks "));
                        data->import_marks = strbuf_detach(&arg, NULL);
+               } else if (!prefixcmp(capname, "dont-update-private")) {
+                       data->dont_update_private = 1;
                } else if (mandatory) {
                        die("Unknown mandatory capability %s. This remote "
                            "helper probably needs newer version of Git.",
@@ -723,7 +726,7 @@ static void push_update_refs_status(struct helper_data *data,
                if (push_update_ref_status(&buf, &ref, remote_refs))
                        continue;
 
-               if (!data->refspecs)
+               if (!data->refspecs || data->dont_update_private)
                        continue;
 
                /* propagate back the update to the remote namespace */


(Plus tests and docs)

Based on this, git-remote-mediawiki could simply use:

commit aa745c3ccb6681df8dc6406b00e0d31b26e72d50
Author: Matthieu Moy <Matthieu.Moy@imag.fr>
Date:   Mon Aug 26 11:09:55 2013 +0200

    git-remote-mediawiki: use dont-update-private capability on dumb push

diff --git a/contrib/mw-to-git/git-remote-mediawiki.perl b/contrib/mw-to-git/git-remote-mediawiki.perl
index a2e71d6..b29682e 100755
--- a/contrib/mw-to-git/git-remote-mediawiki.perl
+++ b/contrib/mw-to-git/git-remote-mediawiki.perl
@@ -601,6 +601,9 @@ sub mw_capabilities {
        print {*STDOUT} "import\n";
        print {*STDOUT} "list\n";
        print {*STDOUT} "push\n";
+       if ($dumb_push) {
+               print {*STDOUT} "dont-update-private\n";
+       }
        print {*STDOUT} "\n";
        return;
 }

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
