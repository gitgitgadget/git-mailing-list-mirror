Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9BC1C1FF40
	for <e@80x24.org>; Wed, 21 Dec 2016 20:59:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755101AbcLUU7b (ORCPT <rfc822;e@80x24.org>);
        Wed, 21 Dec 2016 15:59:31 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:64229 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1752922AbcLUU7a (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 21 Dec 2016 15:59:30 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id EC3CF59458;
        Wed, 21 Dec 2016 15:59:29 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=cP5FUE80iZlp8azAlhrGbI9DZsA=; b=F/LZr8
        w9vONq4QIpG4oQfqrpGZ6ANZ2ck/KEyhdQwbey387xwvDiFjHpQTz2TPgtFtkfhc
        dU4iMouIoe0L7pUXTgceKkbDuKyuea4UtKEuhpOUqYiznlxXC21V2Ywjl0cKfQYC
        qYL07Vw7ZCkcBB3UyfZKh7nZhp9ShvKiZY+Jk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=wZFKfRTBN8bbEPTVwYfmAswFMQBJnDbK
        yD9F9G15DDjemQ+bvQoKvfg3K8LvECz3ht1ZSOjMPTBw+d11tTO0zkmCq/8W+qGL
        Dq2Ppqt70ZokwaGxO79EeW2IpTyO3FVGGfNcAbUtdcEasFFz32Vn4jfyrWw2sBXC
        +gVZpXFWSVI=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id E0D6F59457;
        Wed, 21 Dec 2016 15:59:29 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 4CE0959456;
        Wed, 21 Dec 2016 15:59:29 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Kai Zhang <kai@netskope.com>
Cc:     git@vger.kernel.org
Subject: Re: Bug report: Git pull hang occasionally
References: <9B7DCFB3-73A4-40DE-8FC6-867C5016EF95@netskope.com>
Date:   Wed, 21 Dec 2016 12:59:27 -0800
In-Reply-To: <9B7DCFB3-73A4-40DE-8FC6-867C5016EF95@netskope.com> (Kai Zhang's
        message of "Wed, 21 Dec 2016 11:47:56 -0800")
Message-ID: <xmqq8tr9huc0.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 5D3CF3CA-C7C0-11E6-88C9-B2917B1B28F4-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Kai Zhang <kai@netskope.com> writes:

> 2016/12/20 20:38:10 [error] 9957#0: *687703 FastCGI sent in stderr: "fatal: 'HEAD' is a symref but it is not?" while reading response header from upstream, client: 10.1.0.11, server: server, request: "POST /git/repo_name/.git/git-upload-pack HTTP/1.1", upstream: "fastcgi://unix:/var/run/fcgiwrap.socket:", host: "server"

(Not a solution)

In order to tell the client if HEAD is a symbolic ref and to what
underlying ref it points at if it is a symbolic ref, at the very
beginning of upload-pack, there is a call to head_ref_namespaced()
that uses find_symref().  find_symref() gets "HEAD" and a boolean
that says if it is a symbolic ref, but it does not get where the
symbolic ref points at, so it does resolve_ref_unsafe() to learn
that information.

Between the time head_ref_namespaced() checks the refs database and
finds that HEAD is a symbolic ref, and the time find_symref() calls
resolve_ref_unsafe() to find out where it leads to, if somebody else
updates HEAD, resolve_ref_unsafe() can give an unexpected result, as
all of these read-only operations are performed without any locking.

And the unexpected discrepancy is reported by find_symref() as
fatal.  The server side dies, and somehow that fact is lost between
the upload-pack process and the client and somebody in the middle
(e.g. fastcgi interface or nginx webserver on the server side, or
the remote-curl helper on the client side) keeps the "git fetch"
process waiting.

So there seem to be two issues.  

 - Because of the unlocked read, find_symref() can observe an
   inconsistent state.  Perhaps it should be updated not to die but
   to retry, expecting that transient inconsistency will go away.

 - A fatal error in upload-pack is not reported back to the client
   to cause it exit is an obvious one, and even if we find a way to
   make this fatal error in find_symref() not to trigger, fatal
   errors in other places in the code can trigger the same symptom.

