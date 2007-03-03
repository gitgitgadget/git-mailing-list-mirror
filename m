From: Avi Kivity <avi@qumranet.com>
Subject: Re: [patch] KVM: T60 resume fix
Date: Sat, 03 Mar 2007 10:21:38 +0200
Message-ID: <45E93012.4000100@qumranet.com>
References: <20070227103407.GA17819@elte.hu> <20070227105922.GD2250@kernel.dk>
	<20070227111515.GA4271@kernel.dk> <20070301093450.GA8508@elte.hu>
	<20070301104117.GA22788@elte.hu> <20070301145204.GA25304@elte.hu>
	<Pine.LNX.4.64.0703011536450.12485@woody.linux-foundation.org>
	<20070302072100.GB30634@elte.hu> <20070302080441.GA12785@elte.hu>
	<20070302102018.GA11549@elte.hu> <20070302102216.GA13575@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Cc: Daniel Walker <dwalker@mvista.com>,
   Michal Piotrowski <michal.k.k.piotrowski@gmail.com>,
   linux-pm@lists.osdl.org,
   Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
   Adrian Bunk <bunk@stusta.de>, Pavel Machek <pavel@ucw.cz>,
   Jens Axboe <jens.axboe@oracle.com>,
   "Michael S. Tsirkin" <mst@mellanox.co.il>,
   Thomas Gleixner <tglx@linutronix.de>,
   Linus Torvalds <torvalds@linux-foundation.org>,
   Andrew Morton <akpm@linux-foundation.org>, git@vger.kernel.org
To: Ingo Molnar <mingo@elte.hu>
X-From: linux-pm-bounces@lists.osdl.org Sat Mar 03 09:22:11 2007
Return-path: <linux-pm-bounces@lists.osdl.org>
Envelope-to: gll-linux-pm@gmane.org
Received: from smtp.osdl.org ([65.172.181.24])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HNPVK-000840-PM
	for gll-linux-pm@gmane.org; Sat, 03 Mar 2007 09:22:11 +0100
Received: from fire-2.osdl.org (localhost [127.0.0.1])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id l238Luq8019645;
	Sat, 3 Mar 2007 00:21:58 -0800
Received: from mis011-2.exch011.intermedia.net
	(mis011-2.exch011.intermedia.net [64.78.21.129])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id l238Lrq7019641
	for <linux-pm@lists.osdl.org>; Sat, 3 Mar 2007 00:21:53 -0800
Received: from mis011-2.exch011.intermedia.net ([64.78.21.223]) by
	mis011-2.exch011.intermedia.net with Microsoft
	SMTPSVC(6.0.3790.1830); Sat, 3 Mar 2007 00:21:46 -0800
Received: from [87.69.86.53] ([87.69.86.53]) by
	mis011-2.exch011.intermedia.net over TLS secured channel with
	Microsoft SMTPSVC(6.0.3790.1830); Sat, 3 Mar 2007 00:21:44 -0800
User-Agent: Thunderbird 1.5.0.9 (X11/20070212)
In-Reply-To: <20070302102216.GA13575@elte.hu>
X-OriginalArrivalTime: 03 Mar 2007 08:21:45.0612 (UTC)
	FILETIME=[FB3A94C0:01C75D6C]
Received-SPF: pass (localhost is always allowed.)
X-Spam-Status: No, hits=-3.803 required=5 tests=AWL,OSDL_HEADER_LISTID_KNOWN,OSDL_HEADER_SPF_PASS,OSDL_HEADER_SUBJECT_BRACKETED,PATCH_SUBJECT_OSDL
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.119__
X-MIMEDefang-Filter: osdl$Revision: 1.176 $
X-BeenThere: linux-pm@lists.osdl.org
X-Mailman-Version: 2.1.8
Precedence: list
List-Id: Linux power management <linux-pm.lists.osdl.org>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/41275>

Ingo Molnar wrote:
> Subject: [patch] KVM: T60 resume fix
> From: Ingo Molnar <mingo@elte.hu>
>
> my T60 laptop does not resume correctly due to KVM attempting to send an =

> IPI to a CPU that might be down (or not up yet). (Doing so also triggers =

> the send_IPI_mask_bitmask() warning in arch/i386/kernel/smp.c, line =

> 732.)
>
> with this fix applied my laptop does not hang during resume.
>
> [ KVM will have to disable/enable virtualization on the CPU itself that
>   goes down / comes up, not via an IPI sent from the requesting CPU. ]
>
> Signed-off-by: Ingo Molnar <mingo@elte.hu>
> ---
>  drivers/kvm/kvm_main.c |    6 ------
>  1 file changed, 6 deletions(-)
>
> Index: linux/drivers/kvm/kvm_main.c
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> --- linux.orig/drivers/kvm/kvm_main.c
> +++ linux/drivers/kvm/kvm_main.c
> @@ -2083,12 +2083,6 @@ static int kvm_cpu_hotplug(struct notifi
>  	case CPU_DEAD:
>  	case CPU_UP_CANCELED:
>  		decache_vcpus_on_cpu(cpu);
> -		smp_call_function_single(cpu, kvm_arch_ops->hardware_disable,
> -					 NULL, 0, 1);
> -		break;
> -	case CPU_UP_PREPARE:
> -		smp_call_function_single(cpu, kvm_arch_ops->hardware_enable,
> -					 NULL, 0, 1);
>  		break;
>  	}
>  	return NOTIFY_OK;
>   =


That is already CPU_ONLINE in my tree (and in the pull request sent to =

Linus a couple of days ago).



-- =

Do not meddle in the internals of kernels, for they are subtle and quick to=
 panic.
