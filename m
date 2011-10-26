From: Atsushi Nakagawa <atnak@chejz.com>
Subject: Re: [PATCH/RFC] mingw: implement PTHREAD_MUTEX_INITIALIZER
Date: Tue, 25 Oct 2011 20:05:19 -0700 (PDT)
Message-ID: <16520370.401.1319598319120.JavaMail.geo-discussion-forums@prms22>
References: <1319554509-6532-1-git-send-email-kusmabite@gmail.com>
Reply-To: msysgit@googlegroups.com
Mime-Version: 1.0
Content-Type: multipart/alternative; 
	boundary="----=_Part_400_8158501.1319598319117"
Cc: git@vger.kernel.org, johannes.schindelin@gmx.de, j.sixt@viscovery.net
To: msysgit@googlegroups.com
X-From: msysgit+bncCL3AtdjPFhDK_p71BBoEVZbnlg@googlegroups.com Wed Oct 26 10:05:39 2011
Return-path: <msysgit+bncCL3AtdjPFhDK_p71BBoEVZbnlg@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-gy0-f186.google.com ([209.85.160.186])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <msysgit+bncCL3AtdjPFhDK_p71BBoEVZbnlg@googlegroups.com>)
	id 1RIyUU-0003SU-Bo
	for gcvm-msysgit@m.gmane.org; Wed, 26 Oct 2011 10:05:38 +0200
Received: by gyd8 with SMTP id 8sf2638864gyd.3
        for <gcvm-msysgit@m.gmane.org>; Wed, 26 Oct 2011 01:05:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=beta;
        h=x-beenthere:date:from:reply-to:to:cc:message-id:in-reply-to
         :references:subject:mime-version:x-original-sender:precedence
         :mailing-list:list-id:x-google-group-id:list-post:list-help
         :list-archive:sender:list-subscribe:list-unsubscribe:content-type;
        bh=6pJ4sZHYA32MPYS1YQO1l0QvzxuBLpj4srWd5MHLwAo=;
        b=p8rZKfaMbQhQXbF2Ys6FW2Wyc14SYq45vpe0FXQEXyrrkg6iS5Mrb2kZZiJmT7Tb4O
         CyNABRYM2eT66R5PaGCH4yymGn8FcpRsDVGTJoCx0/a+y3huzCjI6vE7bR9Dgo+u1BCZ
         cIHIxORej9JmEJS2hZt58055KsCW6Dyu6xpHM=
Received: by 10.236.161.34 with SMTP id v22mr8211314yhk.9.1319616330145;
        Wed, 26 Oct 2011 01:05:30 -0700 (PDT)
X-BeenThere: msysgit@googlegroups.com
Received: by 10.101.2.12 with SMTP id e12ls1085080ani.3.gmail; Wed, 26 Oct
 2011 01:05:29 -0700 (PDT)
Received: by 10.100.236.38 with SMTP id j38mr4320888anh.42.1319616329307;
        Wed, 26 Oct 2011 01:05:29 -0700 (PDT)
Received: by 10.150.167.20 with SMTP id p20msybe;
        Tue, 25 Oct 2011 20:05:20 -0700 (PDT)
Received: by 10.100.19.8 with SMTP id 8mr1833173ans.26.1319598319807;
        Tue, 25 Oct 2011 20:05:19 -0700 (PDT)
In-Reply-To: <1319554509-6532-1-git-send-email-kusmabite@gmail.com>
X-Original-Sender: atnak@chejz.com
Precedence: list
Mailing-list: list msysgit@googlegroups.com; contact msysgit+owners@googlegroups.com
List-ID: <msysgit.googlegroups.com>
X-Google-Group-Id: 152234828034
List-Post: <http://groups.google.com/group/msysgit/post?hl=en_US>, <mailto:msysgit@googlegroups.com>
List-Help: <http://groups.google.com/support/?hl=en_US>, <mailto:msysgit+help@googlegroups.com>
List-Archive: <http://groups.google.com/group/msysgit?hl=en_US>
Sender: msysgit@googlegroups.com
List-Subscribe: <http://groups.google.com/group/msysgit/subscribe?hl=en_US>, <mailto:msysgit+subscribe@googlegroups.com>
List-Unsubscribe: <http://groups.google.com/group/msysgit/subscribe?hl=en_US>, <mailto:msysgit+unsubscribe@googlegroups.com>
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/184248>

------=_Part_400_8158501.1319598319117
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On Oct 25, 11:55 pm, Erik Faye-Lund <kusmab...@gmail.com> wrote:
> [...]
> +int pthread_mutex_init(pthread_mutex_t *mutex, const pthread_mutexattr_t 
*attr)
> +{
> +       InitializeCriticalSection(&mutex->cs);
> +       mutex->autoinit = 0;
> +       return 0;
> +}
> +
> +int pthread_mutex_lock(pthread_mutex_t *mutex)
> +{
> +       if (mutex->autoinit) {
> +               if (InterlockedCompareExchange(&mutex->autoinit, -1, 1) 
!= -1) {

I'm making the assumption that mutex->autoinit starts off as 1 before 
things get multi-threaded..

I've only looked at what's in the patch so I could be missing vital 
context..  Anyways, is there a reason why you made this 
"InterlockedCompareExchange(..., -1, 1) != -1" and not 
"InterlockedCompareExchange(..., -1, 1) == 1"?

It looks to me the former adds a race condition after "if (mutex->autoinit) 
{".  e.g. A second thread could reinitialize mutex->cs after the first 
thread has already entered EnterCriticalSection(...).

> +                       pthread_mutex_init(mutex, NULL);
> +                       mutex->autoinit = 0;
> +               } else
> +                       while (mutex->autoinit != 0)
> +                               ; /* wait for other thread */
> +       }
> +
> +       EnterCriticalSection(&mutex->cs);
> +       return 0;
> +}
> [...]

-- 
Atsushi Nakagawa


------=_Part_400_8158501.1319598319117
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div><div>On Oct 25, 11:55 pm, Erik Faye-Lund &lt;kusmab...@gmail.com&gt; w=
rote:<br></div><div>&gt; [...]</div><div>&gt; +int pthread_mutex_init(pthre=
ad_mutex_t *mutex, const pthread_mutexattr_t *attr)</div><div>&gt; +{</div>=
<div>&gt; + &nbsp; &nbsp; &nbsp; InitializeCriticalSection(&amp;mutex-&gt;c=
s);</div><div>&gt; + &nbsp; &nbsp; &nbsp; mutex-&gt;autoinit =3D 0;</div><d=
iv>&gt; + &nbsp; &nbsp; &nbsp; return 0;</div><div>&gt; +}</div><div>&gt; +=
</div><div>&gt; +int pthread_mutex_lock(pthread_mutex_t *mutex)</div><div>&=
gt; +{</div><div>&gt; + &nbsp; &nbsp; &nbsp; if (mutex-&gt;autoinit) {</div=
><div>&gt; + &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; if (Interlock=
edCompareExchange(&amp;mutex-&gt;autoinit, -1, 1) !=3D -1) {</div><div><br>=
</div><div>I'm making the assumption that mutex-&gt;autoinit starts off as =
1 before things get multi-threaded..</div><div><br></div><div>I've only loo=
ked at what's in the patch so I could be missing vital context.. &nbsp;Anyw=
ays, is there a reason why you made this "InterlockedCompareExchange(..., -=
1, 1) !=3D -1" and not "InterlockedCompareExchange(..., -1, 1) =3D=3D 1"?</=
div><div><br></div><div>It looks to me the former adds a race condition aft=
er "if (mutex-&gt;autoinit) {". &nbsp;e.g. A second thread could reinitiali=
ze mutex-&gt;cs after the first thread has already entered EnterCriticalSec=
tion(...).</div><div><br></div><div>&gt; + &nbsp; &nbsp; &nbsp; &nbsp; &nbs=
p; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; pthread_mutex_init(mutex, NULL=
);</div><div>&gt; + &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;=
 &nbsp; &nbsp; &nbsp; mutex-&gt;autoinit =3D 0;</div><div>&gt; + &nbsp; &nb=
sp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; } else</div><div>&gt; + &nbsp; &nbsp=
; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; while (mut=
ex-&gt;autoinit !=3D 0)</div><div>&gt; + &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;=
 &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; ; /*=
 wait for other thread */</div><div>&gt; + &nbsp; &nbsp; &nbsp; }</div><div=
>&gt; +</div><div>&gt; + &nbsp; &nbsp; &nbsp; EnterCriticalSection(&amp;mut=
ex-&gt;cs);</div><div>&gt; + &nbsp; &nbsp; &nbsp; return 0;</div><div>&gt; =
+}</div><div>&gt; [...]</div><div><br></div><div>--&nbsp;</div><div>Atsushi=
 Nakagawa</div></div><div><br></div>
------=_Part_400_8158501.1319598319117--
